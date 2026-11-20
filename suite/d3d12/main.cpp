// main.cpp - the KDP profile plus a Direct3D 12 adapter check (Windows only).
// build with MinGW: x86_64-w64-mingw32-g++ main.cpp -ld3d12 -ldxgi -o main_d3d12.exe
#include <windows.h>
#include <d3d12.h>
#include <dxgi1_4.h>
#include <cstdio>

int main()
{
    std::puts("=== KDP Forum Profile ===");
    std::puts("Nickname : KDPMember:KL5UQ4f48673352");
    std::puts("Code     : KL5UQ4f48673352");
    std::puts("Role     : Member");
    std::puts("Points   : 1");

    IDXGIFactory4 *factory = nullptr;
    if (FAILED(CreateDXGIFactory1(__uuidof(IDXGIFactory4), (void **)&factory))) {
        std::puts("D3D12    : no DXGI factory");
        return 0;
    }
    for (UINT i = 0;; ++i) {
        IDXGIAdapter1 *adapter = nullptr;
        if (factory->EnumAdapters1(i, &adapter) == DXGI_ERROR_NOT_FOUND) break;
        DXGI_ADAPTER_DESC1 d;
        adapter->GetDesc1(&d);
        ID3D12Device *dev = nullptr;
        HRESULT hr = D3D12CreateDevice(adapter, D3D_FEATURE_LEVEL_11_0, __uuidof(ID3D12Device), (void **)&dev);
        std::wprintf(L"Adapter %u: %ls - D3D12 %ls\n", i, d.Description, SUCCEEDED(hr) ? L"yes" : L"no");
        if (dev) dev->Release();
        adapter->Release();
    }
    factory->Release();
    return 0;
}
