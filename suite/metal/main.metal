// main.metal - Metal compute kernel: writes the KDP profile text into a buffer (macOS / iOS only).
// ("main" is reserved in Metal, so the kernel is called main_kernel.)
#include <metal_stdlib>
using namespace metal;

constant uint PROFILE[31] = {
    0x203D3D3D, 0x2050444B, 0x75726F46, 0x7250206D, 0x6C69666F, 0x3D3D2065, 0x694E0A3D, 0x616E6B63,
    0x3A20656D, 0x50444B20, 0x626D654D, 0x4B3A7265, 0x5155354C, 0x38346634, 0x33333736, 0x430A3235,
    0x2065646F, 0x20202020, 0x4C4B203A, 0x34515535, 0x36383466, 0x35333337, 0x6F520A32, 0x2020656C,
    0x3A202020, 0x6D654D20, 0x0A726562, 0x6E696F50, 0x20207374, 0x31203A20, 0x0000000A
};

kernel void main_kernel(device uint *out [[buffer(0)]], uint id [[thread_position_in_grid]])
{
    if (id < 31) out[id] = PROFILE[id];
}
