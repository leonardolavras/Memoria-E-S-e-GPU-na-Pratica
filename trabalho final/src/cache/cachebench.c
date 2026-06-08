#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>

#define MIN_KB 1
#define MAX_KB (256 * 1024)
#define TOTAL_ACCESSES 20000000UL
#define REPEATS 5

static double seconds_now(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec + ts.tv_nsec / 1000000000.0;
}

int main(void) {
    printf("size_kb,ns_per_access\n");

    for (size_t size_kb = MIN_KB; size_kb <= MAX_KB; size_kb *= 2) {
        size_t count = (size_kb * 1024) / sizeof(uint64_t);
        if (count == 0) count = 1;

        volatile uint64_t *values = malloc(count * sizeof(uint64_t));
        if (values == NULL) return 1;

        for (size_t i = 0; i < count; i++) {
            values[i] = i;
        }

        double best_time = 999999.0;
        volatile uint64_t total = 0;
        size_t step = 64 / sizeof(uint64_t);

        for (int r = 0; r < REPEATS; r++) {
            double start = seconds_now();

            for (size_t i = 0; i < TOTAL_ACCESSES; i++) {
                size_t index = (i * step) % count;
                total += values[index];
            }

            double elapsed = seconds_now() - start;
            if (elapsed < best_time) best_time = elapsed;
        }

        double ns = (best_time * 1000000000.0) / TOTAL_ACCESSES;
        printf("%zu,%.4f\n", size_kb, ns);

        free((void *) values);

        if (total == 0) printf("\n");
    }

    return 0;
}
