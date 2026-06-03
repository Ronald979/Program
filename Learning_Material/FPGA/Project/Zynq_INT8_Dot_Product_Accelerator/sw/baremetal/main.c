#include <stdint.h>
#include <stdio.h>
#include "xil_io.h"
#include "xparameters.h"

#ifndef DOTP_BASEADDR
#ifdef XPAR_AXI_LITE_DOT_PRODUCT_0_S_AXI_BASEADDR
#define DOTP_BASEADDR XPAR_AXI_LITE_DOT_PRODUCT_0_S_AXI_BASEADDR
#elif defined(XPAR_AXI_LITE_DOT_PRODUCT_0_S00_AXI_BASEADDR)
#define DOTP_BASEADDR XPAR_AXI_LITE_DOT_PRODUCT_0_S00_AXI_BASEADDR
#elif defined(XPAR_AXI_LITE_DOT_PRODUCT_0_BASEADDR)
#define DOTP_BASEADDR XPAR_AXI_LITE_DOT_PRODUCT_0_BASEADDR
#else
#define DOTP_BASEADDR 0x43C00000U
#endif
#endif

#define DOTP_CONTROL        0x00U
#define DOTP_STATUS         0x04U
#define DOTP_VECTOR_LENGTH  0x08U
#define DOTP_LATENCY_CYCLES 0x0CU
#define DOTP_A0             0x10U
#define DOTP_A1             0x14U
#define DOTP_A2             0x18U
#define DOTP_A3             0x1CU
#define DOTP_B0             0x20U
#define DOTP_B1             0x24U
#define DOTP_B2             0x28U
#define DOTP_B3             0x2CU
#define DOTP_RESULT         0x30U

#define DOTP_CONTROL_START      0x00000001U
#define DOTP_CONTROL_CLEAR_DONE 0x00000002U
#define DOTP_STATUS_BUSY        0x00000001U
#define DOTP_STATUS_DONE        0x00000002U
#define DOTP_TIMEOUT            1000000U

static uint32_t pack_int8x4(int8_t x0, int8_t x1, int8_t x2, int8_t x3)
{
    return ((uint32_t)(uint8_t)x0) |
           ((uint32_t)(uint8_t)x1 << 8) |
           ((uint32_t)(uint8_t)x2 << 16) |
           ((uint32_t)(uint8_t)x3 << 24);
}

static int32_t dot_product_sw(const int8_t *a, const int8_t *b)
{
    int32_t acc = 0;
    int i;

    for (i = 0; i < 16; ++i) {
        acc += (int32_t)a[i] * (int32_t)b[i];
    }

    return acc;
}

static void dotp_write(uint32_t offset, uint32_t value)
{
    Xil_Out32(DOTP_BASEADDR + offset, value);
}

static uint32_t dotp_read(uint32_t offset)
{
    return Xil_In32(DOTP_BASEADDR + offset);
}

static void dotp_load_vectors(const int8_t *a, const int8_t *b)
{
    dotp_write(DOTP_A0, pack_int8x4(a[0],  a[1],  a[2],  a[3]));
    dotp_write(DOTP_A1, pack_int8x4(a[4],  a[5],  a[6],  a[7]));
    dotp_write(DOTP_A2, pack_int8x4(a[8],  a[9],  a[10], a[11]));
    dotp_write(DOTP_A3, pack_int8x4(a[12], a[13], a[14], a[15]));
    dotp_write(DOTP_B0, pack_int8x4(b[0],  b[1],  b[2],  b[3]));
    dotp_write(DOTP_B1, pack_int8x4(b[4],  b[5],  b[6],  b[7]));
    dotp_write(DOTP_B2, pack_int8x4(b[8],  b[9],  b[10], b[11]));
    dotp_write(DOTP_B3, pack_int8x4(b[12], b[13], b[14], b[15]));
}

static int dotp_run(int32_t *result, uint32_t *latency_cycles)
{
    uint32_t timeout = DOTP_TIMEOUT;
    uint32_t status;

    dotp_write(DOTP_CONTROL, DOTP_CONTROL_CLEAR_DONE);
    dotp_write(DOTP_CONTROL, DOTP_CONTROL_START);

    do {
        status = dotp_read(DOTP_STATUS);
        if (status & DOTP_STATUS_DONE) {
            *result = (int32_t)dotp_read(DOTP_RESULT);
            *latency_cycles = dotp_read(DOTP_LATENCY_CYCLES);
            return 0;
        }
    } while (--timeout != 0U);

    return -1;
}

int main(void)
{
    int8_t a[16];
    int8_t b[16];
    int32_t sw_result;
    int32_t pl_result;
    uint32_t latency_cycles;
    uint32_t vector_length;
    int i;

    for (i = 0; i < 16; ++i) {
        a[i] = (int8_t)(i - 8);
        b[i] = (int8_t)(7 - i);
    }

    vector_length = dotp_read(DOTP_VECTOR_LENGTH);
    if (vector_length != 16U) {
        printf("DOTP vector length mismatch: %lu\r\n", (unsigned long)vector_length);
        return 1;
    }

    sw_result = dot_product_sw(a, b);
    dotp_load_vectors(a, b);

    if (dotp_run(&pl_result, &latency_cycles) != 0) {
        printf("DOTP timeout, status=0x%08lX\r\n", (unsigned long)dotp_read(DOTP_STATUS));
        return 1;
    }

    printf("SW result = %ld\r\n", (long)sw_result);
    printf("PL result = %ld\r\n", (long)pl_result);
    printf("PL latency cycles = %lu\r\n", (unsigned long)latency_cycles);

    if (sw_result != pl_result) {
        printf("FAIL\r\n");
        return 1;
    }

    printf("PASS\r\n");
    return 0;
}
