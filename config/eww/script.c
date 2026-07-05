#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define BARS 100          
#define WIDTH 300        
#define HEIGHT 22        
#define FLOOR 0          

int main() {
    setvbuf(stdin, NULL, _IOFBF, BARS * sizeof(unsigned short));
    setvbuf(stdout, NULL, _IOFBF, 1024);

    unsigned short sample_buffer[BARS]; 
    float step = (float)WIDTH / (BARS - 1); 
    int toggle = 0;

    // open both ram files once to eliminate fopen/fclose overhead in the hot loop
    FILE *fps[2];
    fps[0] = fopen("/tmp/cava_0.svg", "w+");
    fps[1] = fopen("/tmp/cava_1.svg", "w+");

    if (!fps[0] || !fps[1]) {
        perror("failed to open ram files");
        return 1;
    }

    const float scale = (float)(HEIGHT - (FLOOR * 2)) / 65535.0f;

    while (fread(sample_buffer, sizeof(unsigned short), BARS, stdin) == BARS) {
        FILE *fp = fps[toggle];
        rewind(fp);
        if (ftruncate(fileno(fp), 0) != 0) continue; 

        // open svg wrapper with layout safe viewBox rules
        fprintf(fp, "<svg width=\"%d\" height=\"%d\" viewBox=\"-8 -2 %d %d\" preserveAspectRatio=\"none\" xmlns=\"http://www.w3.org/2000/svg\">", 
                WIDTH, HEIGHT, WIDTH + 16, HEIGHT + 4);
        
        // inject the neon glow filter configurations
        fprintf(fp, "<defs>"
                    "<filter id=\"glow\" x=\"-20%%\" y=\"-20%%\" width=\"140%%\" height=\"140%%\">"
                    "<feGaussianBlur stdDeviation=\"1.5\" result=\"blur\"/>"
                    "<feMerge>"
                    "<feMergeNode in=\"blur\"/>"
                    "<feMergeNode in=\"SourceGraphic\"/>"
                    "</feMerge>"
                    "</filter>"
                    "</defs>");
        
        int start_y = HEIGHT - FLOOR - (int)(sample_buffer[0] * scale);
        // apply the filter tag directly to the path properties
        fprintf(fp, "<path filter=\"url(#glow)\" d=\"M 0,%d ", start_y);

        for (int i = 1; i < BARS - 1; i++) {
            float x1 = i * step;
            int y1 = HEIGHT - FLOOR - (int)(sample_buffer[i] * scale);
            
            float x2 = (i + 1) * step;
            int y2 = HEIGHT - FLOOR - (int)(sample_buffer[i+1] * scale);

            float cx = (x1 + x2) / 2.0f;
            int cy = (y1 + y2) / 2;

            fprintf(fp, "Q %.1f,%d %.1f,%d ", x1, y1, cx, cy);
        }

        fprintf(fp, "\" stroke=\"rgba(113, 153, 238, 1.0)\" stroke-width=\"1\" stroke-linecap=\"round\" fill=\"none\"/>");
        fprintf(fp, "</svg>\n");
        fflush(fp); 

        // send path to eww stdout listener
        printf("/tmp/cava_%d.svg\n", toggle);
        fflush(stdout);

        toggle = !toggle;
    }

    fclose(fps[0]);
    fclose(fps[1]);
    return 0;
}
