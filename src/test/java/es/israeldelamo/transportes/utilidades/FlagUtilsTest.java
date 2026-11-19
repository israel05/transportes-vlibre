package es.israeldelamo.transportes.utilidades;


import javafx.scene.image.Image;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class FlagUtilsTest {

    @Test
    public void testGetFlagPNG_NonExistingCountry() {
        // Test with a non-existing country
        Image imageView = FlagUtils.getFlagPNG("Atlantis");
        assertNull(imageView, "ImageView should be null for non-existing country");
    }

    @Test
    public void testGetFlagPNG_NullCountry() {
        // Test with null country
        Image imageView = FlagUtils.getFlagPNG(null);
        assertNull(imageView, "ImageView should be null for null country");
    }

}