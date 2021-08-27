// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

struct Vector
{
    double i;
    double j;
    double k;
};


char* teststring();
int add(int a, int b);
char *reverse(char *str, int length);
void free_string(char* str);
struct Vector create_vector(double i, double j, double k);
struct Vector add_vector(struct Vector a, struct Vector b);
struct Vector scale_vector(struct Vector a, double scale);
struct Vector inverse_vector(struct Vector a);
double dot_product(struct Vector a, struct Vector b);
struct Vector cross_product(struct Vector a, struct Vector b);
