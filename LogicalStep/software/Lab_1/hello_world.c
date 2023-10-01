#include <stdint.h>
#include <stdio.h>

#include "altera_avalon_pio_regs.h"
#include "sys/alt_irq.h"
#include "system.h"

#define ENABLE_REG_OFFSET 0
#define BUSY_REG_OFFSET 1
#define PERIOD_REG_OFFSET 2
#define PULSE_WIDTH_REG_OFFSET 3
#define AVERAGE_LATENCY_REG_OFFSET 4
#define MISSED_REG_OFFSET 5
#define MULTI_REG_OFFSET 6

void enable_egm(uint16_t period);
void disable_egm();
void print_statistics(uint16_t period, uint64_t tasks_run);
static void response_interrupt(void *context, alt_u32 id);
uint8_t is_busy();

volatile int triggered = 0;

int main() {
	// TODO: Name something better than this. -- throw this inside a function
	// 0 -> interrupts vs 1 -> polling
	// uint8_t interrupts_or_polling = IORD(SW_BASE, SW_OFFSET);
	// if (interrupts_or_polling) {}
	// else {}

	puts("Interrupt mode selected.");
	puts("Tight polling mode selected");
	puts("Period, Pulse_Width, BG_Tasks Run, Latency, Missed, Multiple");

	puts("Please, press PB0 to continue.");

	while(1) {
		if (IORD(BUTTON_PIO_BASE, 0) == 1) {
			break;
		}
	}

	puts("made it through");

//	volatile uint8_t busy_bit;
//
//	for (uint16_t period = 2; period <= 5000; period += 2) {
//		busy_bit = 1;
//		enable_egm(period);
//
//		interrupt_routine();

//		print_statistics();
//		disable_egm();
//	}

  return 0;
}

void print_statistics(uint16_t period, uint64_t tasks_run) {
	uint16_t pulse_width = period / 2;
	uint16_t latency = IORD(EGM_BASE, AVERAGE_LATENCY_REG_OFFSET);
	uint16_t missed = IORD(EGM_BASE, MISSED_REG_OFFSET);
	uint16_t multiple = IORD(EGM_BASE, MULTI_REG_OFFSET);
	printf("%d, %d, %d, %d, %d, %d\n", period, pulse_width, tasks_run);
}

void enable_egm(uint16_t period) {
  uint16_t pulse_width = period / 2;

  // Configure EGM period and pulse width
  IOWR(EGM_BASE, PERIOD_REG_OFFSET, period);
  IOWR(EGM_BASE, PULSE_WIDTH_REG_OFFSET, pulse_width);

  // Enable EGM
  IOWR(EGM_BASE, ENABLE_REG_OFFSET, 1);
}

void disable_egm() { IOWR(EGM_BASE, ENABLE_REG_OFFSET, 0); }
uint8_t is_busy() { return IORD(EGM_BASE, BUSY_REG_OFFSET); }

void interrupt_routine() {
	alt_irq_register(STIMULUS_IN_IRQ, (void*)0, response_interrupt);

	while (is_busy()) {
		if (triggered == 1) {
		    IOWR(RESPONSE_OUT_BASE, 0, 1);
		    IOWR(RESPONSE_OUT_BASE, 0, 0);
			triggered = 0;
		}
	}
}

static void response_interrupt(void *context, alt_u32 id) {
    triggered = 1;
}

void tight_polling() {
  //	characterize before we get to this point

  while (is_busy()) {
    if (IORD(STIMULUS_IN_BASE, 0) == 1) {
      IOWR(RESPONSE_OUT_BASE, 0, 1);
      IOWR(RESPONSE_OUT_BASE, 0, 0);
    }
  }
}

