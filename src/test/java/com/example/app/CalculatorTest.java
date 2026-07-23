package com.example.app;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class CalculatorTest {

    Calculator calc = new Calculator();

    @Test
    void testAdd(){
        assertEquals(8, calc.add(5,3));
    }

    @Test
    void testSubtract(){
        assertEquals(2, calc.subtract(5,3));
    }

    @Test
    void testMultiply(){
        assertEquals(15, calc.multiply(5,3));
    }

    @Test
    void testDivide(){
        assertEquals(2, calc.divide(6,3));
    }
}
