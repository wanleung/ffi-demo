import 'dart:io' show Directory, Platform;
import 'dart:ffi';
import 'package:path/path.dart' as path;
import 'package:ffi/ffi.dart';

class Vector extends Struct {
    @Double()
    double i;

    @Double()
    double j;

    @Double()
    double k;
}

/*
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
*/

typedef teststring = Pointer<Utf8> Function();

typedef reverse_native = Pointer<Utf8> Function(
    Pointer<Utf8> str, Int32 length);
typedef Reverse = Pointer<Utf8> Function(Pointer<Utf8> str, int length);

typedef free_string_native = Void Function(Pointer<Utf8> str);
typedef FreeString = void Function(Pointer<Utf8> str);

typedef create_vector_native = Vector Function(
    Double i, Double j, Double k);
typedef CreateVector = Vector Function(
    double i, double j, double k);

typedef add_vector_native = Vector Function(
    Vector a, Vector b);
typedef AddVector = Vector Function(
    Vector a, Vector b);

typedef scale_vector_native = Vector Function(
    Vector a, Double scale);
typedef ScaleVector = Vector Function(
    Vector a, double scale);

typedef inverse_vector_native = Vector Function(
    Vector a);
typedef InverseVector = Vector Function(
    Vector a);

typedef dot_product_native = Double Function(
    Vector a, Vector b);
typedef DotProduct = double Function(
    Vector a, Vector b);

typedef cross_product_native = Vector Function(
    Vector a, Vector b);
typedef CrossProduct = Vector Function(
    Vector a, Vector b);


var libraryPath = path.join(Directory.current.path, 'test_library', 'libtest.so');
final dylib = DynamicLibrary.open(libraryPath);

final test_string = dylib.lookupFunction<teststring, teststring>('teststring');

final reverse = dylib.lookupFunction<reverse_native, Reverse>('reverse');
final freeString = dylib.lookupFunction<free_string_native, FreeString>('free_string');

final createVector = dylib.lookupFunction<create_vector_native, CreateVector>('create_vector');
final addVector = dylib.lookupFunction<add_vector_native, AddVector>('add_vector');
final scaleVector = dylib.lookupFunction<scale_vector_native, ScaleVector>('scale_vector');
final inverseVector = dylib.lookupFunction<inverse_vector_native, InverseVector>('inverse_vector');
final dotProduct = dylib.lookupFunction<dot_product_native, DotProduct>('dot_product');
final crossProduct = dylib.lookupFunction<cross_product_native, CrossProduct>('cross_product');

