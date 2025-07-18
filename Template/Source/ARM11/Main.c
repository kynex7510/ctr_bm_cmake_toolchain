#include <drivers/gfx.h>
#include <arm11/console.h>
#include <arm11/power.h>
#include <arm11/fmt.h>
#include <arm11/drivers/hid.h>

int main(void) {
    GFX_init(GFX_BGR565, GFX_BGR565, GFX_TOP_2D);
    GFX_setLcdLuminance(80);
    consoleInit(GFX_LCD_TOP, NULL);

    ee_printf("Hello World!\n");
    ee_printf("Press Start to exit.\n");
    
    while (true) {
        hidScanInput();

        const u32 kDown = hidKeysDown();
        if (kDown & KEY_START)
            break;

        GFX_flushBuffers();
        GFX_swapBuffers();
        GFX_waitForVBlank0();
    }

    GFX_deinit();
    power_off();
    return 0;
}