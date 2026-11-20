// main.hlsl - HLSL compute shader: writes the KDP profile text (121 bytes, packed 4 per uint) into a buffer.
// compile: dxc -T cs_6_0 -E main main.hlsl -Fo main.cso
RWByteAddressBuffer Out : register(u0);

static const uint PROFILE[31] = {
    0x203D3D3D, 0x2050444B, 0x75726F46, 0x7250206D, 0x6C69666F, 0x3D3D2065, 0x694E0A3D, 0x616E6B63,
    0x3A20656D, 0x50444B20, 0x626D654D, 0x4B3A7265, 0x5155354C, 0x38346634, 0x33333736, 0x430A3235,
    0x2065646F, 0x20202020, 0x4C4B203A, 0x34515535, 0x36383466, 0x35333337, 0x6F520A32, 0x2020656C,
    0x3A202020, 0x6D654D20, 0x0A726562, 0x6E696F50, 0x20207374, 0x31203A20, 0x0000000A
};

[numthreads(31, 1, 1)]
void main(uint3 id : SV_DispatchThreadID)
{
    Out.Store(id.x * 4, PROFILE[id.x]);
}
