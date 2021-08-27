#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "test.h"

int main()
{
    char* mystr = teststring();
    printf("%s\n", mystr);
    int x = 2;
    int y = 3;
    printf("%d + %d = %d\n", x, y, add(x,y));
    char* str = reverse(mystr, strlen(mystr));
    printf("%s\n", str);
    free_string(str);

    struct Vector a = create_vector(4,3,2);
    struct Vector b = create_vector(2,3,4);
    struct Vector c = create_vector(3,4,2);

    printf("Vector A = [%.2f, %.2f, %.2f]\n", a.i, a.j, a.k);
    printf("Vector B = [%.2f, %.2f, %.2f]\n", b.i, b.j, b.k);
    printf("Vector C = [%.2f, %.2f, %.2f]\n", c.i, c.j, c.k);

    struct Vector ab = cross_product(a, b);
    printf("Vector AB = [%.2f, %.2f, %.2f]\n", ab.i, ab.j, ab.k);
    struct Vector bc = cross_product(b, c);
    printf("Vector BC = [%.2f, %.2f, %.2f]\n", bc.i, bc.j, bc.k);
    struct Vector ca = cross_product(c, a);
    printf("Vector CA = [%.2f, %.2f, %.2f]\n", ca.i, ca.j, ca.k);

    double adotbc = dot_product(a, bc);
    double bdotca = dot_product(b, ca);
    double cdotab = dot_product(c, ab);

    printf("%2f, %2f, %2f\n", adotbc, bdotca, cdotab);
   
    struct Vector inv_a = inverse_vector(a);
    printf("Vector -A = [%.2f, %.2f, %.2f]\n", inv_a.i, inv_a.j, inv_a.k);

    struct Vector aaddinv_a = add_vector(a, inv_a);
    printf("Vector A+(-A) = [%.2f, %.2f, %.2f]\n", aaddinv_a.i, aaddinv_a.j, aaddinv_a.k);
    struct Vector aaddb = add_vector(a, b);
    printf("Vector A+B = [%.2f, %.2f, %.2f]\n", aaddb.i, aaddb.j, aaddb.k);
    return 0;
}

char* teststring()
{
    return "This is a test";
}

int add(int a, int b)
{
    return a + b ;
}

char *reverse(char *str, int length)
{
    // Allocates native memory in C.
    char *reversed_str = (char *)malloc((length + 1) * sizeof(char));
    for (int i = 0; i < length; i++)
    {
        reversed_str[length - i - 1] = str[i];
    }
    reversed_str[length] = '\0';
    return reversed_str;
}

void free_string(char *str)
{
    // Free native memory in C which was allocated in C.
    free(str);
}

struct Vector create_vector(double i, double j, double k)
{
    struct Vector vector;
    vector.i = i;
    vector.j = j;
    vector.k = k;
    return vector;
}

struct Vector add_vector(struct Vector a, struct Vector b)
{
    struct Vector result;
    result.i = a.i + b.i;
    result.j = a.j + b.j;
    result.k = a.k + b.k;
    return result;
}

struct Vector scale_vector(struct Vector a, double scale)
{
    struct Vector result;
    result.i = a.i * scale;
    result.j = a.j * scale;
    result.k = a.k * scale;
    return result;
}

struct Vector inverse_vector(struct Vector a)
{
    return scale_vector(a, -1.0);
}

double dot_product(struct Vector a, struct Vector b)
{
    return (a.i*b.i)+(a.j*b.j)+(a.k*b.k);
}

struct Vector cross_product(struct Vector a, struct Vector b)
{
    struct Vector v;
    v.i = (a.j*b.k)-(a.k*b.j);
    v.j = -1 * ((a.i*b.k)-(a.k*b.i));
    v.k = (a.i*b.j)-(a.j*b.i);
    return v;
}
