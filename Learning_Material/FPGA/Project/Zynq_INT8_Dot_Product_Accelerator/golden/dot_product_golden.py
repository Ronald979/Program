#!/usr/bin/env python3

CASES = {
    "zero": ([0] * 16, [0] * 16),
    "all_one": ([1] * 16, [1] * 16),
    "mixed_sign": ([i - 8 for i in range(16)], [7 - i for i in range(16)]),
    "max_magnitude_negative": ([127] * 16, [-128] * 16),
    "alternating": ([(-3 if i & 1 else 5) for i in range(16)],
                    [(11 if i & 2 else -7) for i in range(16)]),
}


def int8(value):
    value &= 0xFF
    return value - 0x100 if value & 0x80 else value


def dot_product(a_vec, b_vec):
    if len(a_vec) != 16 or len(b_vec) != 16:
        raise ValueError("vector length must be 16")
    return sum(int8(a) * int8(b) for a, b in zip(a_vec, b_vec))


def pack4(values):
    word = 0
    for i, value in enumerate(values):
        word |= (value & 0xFF) << (8 * i)
    return word


def main():
    for name, (a_vec, b_vec) in CASES.items():
        result = dot_product(a_vec, b_vec)
        a_words = [pack4(a_vec[i:i + 4]) for i in range(0, 16, 4)]
        b_words = [pack4(b_vec[i:i + 4]) for i in range(0, 16, 4)]
        print(f"case={name}")
        print("  A words:", " ".join(f"0x{word:08X}" for word in a_words))
        print("  B words:", " ".join(f"0x{word:08X}" for word in b_words))
        print(f"  expected int32: {result} (0x{result & 0xFFFFFFFF:08X})")


if __name__ == "__main__":
    main()
