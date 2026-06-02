$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot
$Rtl = Join-Path $Root "rtl"
$Tb = Join-Path $Root "tb"
$Build = Join-Path $Root "build"

New-Item -ItemType Directory -Force $Build | Out-Null

iverilog -g2012 -o (Join-Path $Build "core_tb.vvp") `
    (Join-Path $Rtl "int8_mac.v") `
    (Join-Path $Rtl "int8_dot_product_core.v") `
    (Join-Path $Tb "tb_int8_dot_product_core.v")
vvp (Join-Path $Build "core_tb.vvp")

iverilog -g2012 -o (Join-Path $Build "axi_tb.vvp") `
    (Join-Path $Rtl "int8_mac.v") `
    (Join-Path $Rtl "int8_dot_product_core.v") `
    (Join-Path $Rtl "axi_lite_dot_product.v") `
    (Join-Path $Tb "tb_axi_lite_dot_product.v")
vvp (Join-Path $Build "axi_tb.vvp")
