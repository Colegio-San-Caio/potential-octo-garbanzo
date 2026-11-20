/* app.c - KdpSuite.exe, the Windows app that goes into the Store package.
   build: x86_64-w64-mingw32-gcc -mwindows -o KdpSuite.exe app.c */
#include <windows.h>

int WINAPI WinMain(HINSTANCE inst, HINSTANCE prev, LPSTR cmd, int show)
{
    MessageBoxA(NULL,
        "=== KDP Forum Profile ===\n"
        "Nickname : KDPMember:KL5UQ4f48673352\n"
        "Code     : KL5UQ4f48673352\n"
        "Role     : Member\n"
        "Points   : 1\n\n"
        "Sample mains: C++ (STL), HLSL, Lua, Vulkan, Direct3D 12, Metal, Python.",
        "KDP Profile Suite", MB_OK | MB_ICONINFORMATION);
    return 0;
}
