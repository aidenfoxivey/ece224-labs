#include <stdio.h>
#include <stdint.h>

#include "system.h"
#include "altera_avalon_pio_regs.h"

#define EGM_ENABLE_BIT 1
#define EGM_DISABLE_BIT 0

#define ENABLE_REG_OFFSET 0
#define BUSY_REG_OFFSET 1
#define PERIOD_REG_OFFSET 2
#define PULSE_WIDTH_REG_OFFSET 3
#define	AVERAGE_LATENCY_REG_OFFSET 4
#define MISSED_REG_OFFSET 5
#define MULTI_REG_OFFSET 6

void enable_egm(uint16_t period);
void disable_egm();
uint8_t is_busy();

int main()
{
  volatile uint8_t busy_bit = 1;
  enable_egm(200);

  while(busy_bit != 0) {
	  busy_bit = is_busy();

	  printf("Busy: %d\n", busy_bit);
  }

  printf("Exiting ... \n");
  disable_egm();

  return 0;
}

void enable_egm(uint16_t period)
{
	uint16_t pulse_width = period / 2;

	// Configure EGM period and pulse width
	IOWR(EGM_BASE, PERIOD_REG_OFFSET, period);
	IOWR(EGM_BASE, PULSE_WIDTH_REG_OFFSET, pulse_width);

	// Enable EGM
	IOWR(EGM_BASE, ENABLE_REG_OFFSET, EGM_ENABLE_BIT);
}

void disable_egm()
{
	// Disable EGM
	IOWR(EGM_BASE, ENABLE_REG_OFFSET, EGM_DISABLE_BIT);
}

uint8_t is_busy() {
	return IORD(EGM_BASE, BUSY_REG_OFFSET);
}