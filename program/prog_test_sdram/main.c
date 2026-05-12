#include <stdint.h>

#define SWITCH_ADR ((volatile uint32_t *)0x04003080u) /* SW.s1 */
#define LEDS_ADR   ((volatile uint32_t *)0x04003070u) /* LED.s1 */


int main(void)
{
	uint32_t switches = 0u;
	while (1)
	{
		switches = *(SWITCH_ADR);
		*(LEDS_ADR) = (switches & 0xFFu);
	}
}
