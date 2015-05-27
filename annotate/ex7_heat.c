/* 2D heat equation

   Authors: Jussi Enkovaara, ...
   Copyright (C) 2014  CSC - IT Center for Science Ltd.

   Licensed under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   Code is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   Copy of the GNU General Public License can be onbtained from
   see <http://www.gnu.org/licenses/>.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#include "ex7_heat.h"
#include "pngwriter.h"

// Utility routine for allocating a two dimensional array
double **malloc_2d(int nx, int ny)
{
    double **array;
    int i;

    array = (double **) malloc(nx * sizeof(double *));
    array[0] = (double *) malloc(nx * ny * sizeof(double));

    for (i = 1; i < nx; i++) {
        array[i] = array[0] + i * ny;
    }

    return array;
}


// Utility routine for deallocating a two dimensional array
void free_2d(double **array)
{
    free(array[0]);
    free(array);
}

// Initialize the metadata. Note that the nx is the size of the first
// dimension and ny the second.
void initialize_field_metadata(field * temperature, int nx, int ny)
{
    temperature->dx = DX;
    temperature->dy = DY;
    temperature->dx2 = DX * DX;
    temperature->dy2 = DY * DY;
    temperature->nx = nx;
    temperature->ny = ny;
}

// Copy data on temperature1 into temperature2
void copy_field(field * temperature1, field * temperature2)
{
    assert(temperature1->nx = temperature2->nx);
    assert(temperature1->ny = temperature2->ny);
    memcpy(temperature2->data[0], temperature1->data[0],
           (temperature1->nx + 2) * (temperature1->ny +
                                     2) * sizeof(double));
}

// Swap the data of fields temperature1 and temperature2
void swap_fields(field * temperature1, field * temperature2)
{
    double **tmp;
    tmp = temperature1->data;
    temperature1->data = temperature2->data;
    temperature2->data = tmp;
}

void initialize(field * temperature1, field * temperature2)
{
    int i, j;

    // Allocate also ghost layers
    temperature1->data =
        malloc_2d(temperature1->nx + 2, temperature1->ny + 2);
    temperature2->data =
        malloc_2d(temperature2->nx + 2, temperature2->ny + 2);

    // First zero out the inner part of the array
    for (i = 1; i < temperature1->nx + 1; i++)
        for (j = 1; j < temperature1->ny + 1; j++)
            temperature1->data[i][j] = 0.0;

    for (i = 0; i < temperature1->nx + 2; i++) {
        temperature1->data[i][0] = 30.0;
        temperature1->data[i][temperature1->ny + 1] = -10.0;
    }

    for (j = 0; j < temperature1->ny + 2; j++) {
        temperature1->data[0][j] = 15.0;
        temperature1->data[temperature1->nx + 1][j] = -25.0;
    }

    copy_field(temperature1, temperature2);

}

void evolve(field * curr, field * prev, double a, double dt)
{
    int i, j;

    // Determine the temperature field at next time step
    // As we have fixed boundary conditions, the outermost gridpoints
    // are not updated
    // *INDENT-OFF*
    for (i = 1; i < curr->nx + 1; i++)
        for (j = 1; j < curr->ny + 1; j++) {
            curr->data[i][j] = prev->data[i][j] + a * dt *
                ((      prev->data[i + 1][j] -
                  2.0 * prev->data[  i  ][j] +
                        prev->data[i - 1][j]) / prev->dx2 +
                 (      prev->data[i][j + 1] -
                  2.0 * prev->data[i][  j  ] +
                        prev->data[i][j - 1]) / prev->dy2);
        }
    // *INDENT-ON*

}

void finalize(field * temperature1, field * temperature2)
{
    free_2d(temperature1->data);
    free_2d(temperature2->data);
}

void output(field * temperature, int iter)
{
    char filename[64];

    // The actual write routine takes only the actual data
    // (without ghost layers) so we need array for that
    int height, width;
    double **full_data;

    int i;

    height = temperature->nx;
    width = temperature->ny;

    // Copy the inner data
    full_data = malloc_2d(height, width);
    for (i = 0; i < temperature->nx; i++)
        memcpy(full_data[i], &temperature->data[i + 1][1],
               temperature->ny * sizeof(double));

    sprintf(filename, "%s_%04d.png", "heat", iter);
    save_png(full_data[0], height, width, filename, 'c');

    free(full_data);
}

void read_input(field * temperature1, field * temperature2, char *filename)
{
    FILE *fp;
    int nx, ny, i, j;

    fp = fopen(filename, "r");
    // Read the header
    fscanf(fp, "# %d %d \n", &nx, &ny);

    initialize_field_metadata(temperature1, nx, ny);
    initialize_field_metadata(temperature2, nx, ny);

    // Allocate arrays (including ghost layers
    temperature1->data = malloc_2d(nx + 2, ny + 2);
    temperature2->data = malloc_2d(nx + 2, ny + 2);

    // Read the actual data
    for (i = 1; i < nx + 1; i++) {
        for (j = 1; j < ny + 1; j++) {
            fscanf(fp, "%lf", &temperature1->data[i][j]);
        }
    }

    // Set the boundary values
    for (i = 1; i < nx + 1; i++) {
        temperature1->data[i][0] = temperature1->data[i][1];
        temperature1->data[i][ny + 1] = temperature1->data[i][ny];
    }
    for (j = 0; j < ny + 2; j++) {
        temperature1->data[0][j] = temperature1->data[1][j];
        temperature1->data[nx + 1][j] = temperature1->data[nx][j];
    }

    copy_field(temperature1, temperature2);

    fclose(fp);
}
