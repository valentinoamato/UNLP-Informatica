package ar.edu.unlp.info.oo1;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class PrismaRectangularTest {
    protected PrismaRectangular prismaRectangular1;
    protected PrismaRectangular prismaRectangular2;

    @BeforeEach
    void setUp() {
        this.prismaRectangular1 = new PrismaRectangular("Acero", "Rojo", 3, 4, 5);
        this.prismaRectangular2 = new PrismaRectangular("Madera", "Verde", 4, 5 ,6);
    }

    @Test
    void testGetVolumen() {
        assertEquals(this.prismaRectangular1.getVolumen(), 60.0, 0.1);
        assertEquals(this.prismaRectangular2.getVolumen(), 120.0, 0.1);
    }

    @Test
    void testGetSuperficie() {
        assertEquals(this.prismaRectangular1.getSuperficie(), 94.0, 0.1);
        assertEquals(this.prismaRectangular2.getSuperficie(), 148.0, 0.1);
    }
}
