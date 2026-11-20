/* main.c - the KDP profile plus a Vulkan instance check.  build: cc main.c -lvulkan */
#include <stdio.h>
#include <vulkan/vulkan.h>

int main(void)
{
    puts("=== KDP Forum Profile ===");
    puts("Nickname : KDPMember:KL5UQ4f48673352");
    puts("Code     : KL5UQ4f48673352");
    puts("Role     : Member");
    puts("Points   : 1");

    VkApplicationInfo app = { VK_STRUCTURE_TYPE_APPLICATION_INFO, NULL, "KDP", 1, "none", 0, VK_API_VERSION_1_0 };
    VkInstanceCreateInfo ci = { VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO, NULL, 0, &app, 0, NULL, 0, NULL };
    VkInstance inst;
    if (vkCreateInstance(&ci, NULL, &inst) != VK_SUCCESS) {
        puts("Vulkan   : no instance (no driver installed?)");
        return 0;
    }
    uint32_t n = 0;
    vkEnumeratePhysicalDevices(inst, &n, NULL);
    printf("Vulkan   : %u device(s)\n", n);
    if (n > 8) n = 8;
    VkPhysicalDevice dev[8];
    vkEnumeratePhysicalDevices(inst, &n, dev);
    for (uint32_t i = 0; i < n; i++) {
        VkPhysicalDeviceProperties p;
        vkGetPhysicalDeviceProperties(dev[i], &p);
        printf("  [%u] %s\n", i, p.deviceName);
    }
    vkDestroyInstance(inst, NULL);
    return 0;
}
