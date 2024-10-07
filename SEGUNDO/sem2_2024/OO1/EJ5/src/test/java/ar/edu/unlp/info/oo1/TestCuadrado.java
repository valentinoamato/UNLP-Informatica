package ar.edu.unlp.info.oo1;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class TestCuadrado {

	private Cuadrado cuadrado;

	@BeforeEach
	public void setUp() {
		cuadrado = new Cuadrado();
		cuadrado.setLado(3);
	}

	@Test
	public void testArea() {
		assertEquals(9, cuadrado.getArea());
	}

	@Test
	public void testLado() {
		assertEquals(3, cuadrado.getLado());
	}

	@Test
	public void testPerimetro() {
		assertEquals(12, cuadrado.getPerimetro());
	}
}
