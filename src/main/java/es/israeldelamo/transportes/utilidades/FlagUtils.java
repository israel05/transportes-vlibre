package es.israeldelamo.transportes.utilidades;

import javafx.scene.Node;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.web.WebView;

import java.net.URL;
import java.util.Map;
import java.util.Objects;

public class FlagUtils {

    /**
     * Horrible mapa de los paises principales para poder poner banderitas según demanda del cliente
     */
    static Map<String, String> flags = Map.ofEntries(
            Map.entry("Alemania", "Alemania.png"),
            Map.entry("Austria", "Austria.png"),
            Map.entry("Bélgica", "Bélgica.png"),
            Map.entry("Bulgaria", "Bulgaria.png"),
            Map.entry("China", "China.png"),
            Map.entry("Chipre", "Chipre.png"),
            Map.entry("Croacia", "Croacia.png"),
            Map.entry("Dinamarca", "Dinamarca.png"),
            Map.entry("Eslovaquia", "Eslovaquia.png"),
            Map.entry("Eslovenia", "Eslovenia.png"),
            Map.entry("España", "España.png"),
            Map.entry("Estonia", "Estonia.png"),
            Map.entry("Europa", "Europa.png"),
            Map.entry("Finlandia", "Finlandia.png"),
            Map.entry("Francia", "Francia.png"),
            Map.entry("Grecia", "Grecia.png"),
            Map.entry("Hungría", "Hungría.png"),
            Map.entry("Irlanda", "Irlanda.png"),
            Map.entry("Israel", "Israel.png"),
            Map.entry("Italia", "Italia.png"),
            Map.entry("Letonia", "Letonia.png"),
            Map.entry("Lituania", "Lituania.png"),
            Map.entry("Luxemburgo", "Luxemburgo.png"),
            Map.entry("Malta", "Malta.png"),
            Map.entry("Países Bajos", "Países_Bajos.png"),
            Map.entry("Polonia", "Polonia.png"),
            Map.entry("Portugal", "Portugal.png"),
            Map.entry("República Checa", "República_Checa.png"),
            Map.entry("Rumanía", "Rumanía.png"),
            Map.entry("Suecia", "Suecia.png"),
            Map.entry("Turquía", "Turquía.png")
    );

    /**
     * Devuelve una Image con la bandera correspondiente.
     */
    public static Image getFlagPNG(String country) {
        // Handle null country parameter
        if (country == null) {
            return null;
        }

        String bandera = flags.get(country);

        // Si no existe el país en el mapa
        if (bandera == null) {
            return null;
        }

        // Carga desde recursos
        try {
            URL resourceUrl = FlagUtils.class.getResource("/es/israeldelamo/transportes/imagenes/banderas/" + bandera);
            if (resourceUrl == null) {
                return null;
            }
            
            Image image = new Image(resourceUrl.toExternalForm());
            return image;
        } catch (Exception e) {
            // If there's any error loading the image, return null
            return null;
        }
    }

//
//
//    /**
//     * Devuelve un Nodo (WebView) con la bandera SVG cargada.
//     * Se usa WebView porque JavaFX Image no soporta SVG de forma nativa.
//     */
//    public static Node getFlagSVG(String country) {
//        String archivoBandera = flags.get(country);
//
//        if (archivoBandera == null) {
//            return null;
//        }
//
//        // Construcción de la ruta correcta con la / necesaria
//        URL resourceUrl = FlagUtils.class.getResource("/es/israeldelamo/transportes/imagenes/banderas/" + archivoBandera);
//
//        if (resourceUrl == null) {
//            return null;
//        }
//
//        WebView webView = new WebView();
//        // Cargamos la URL del SVG directamente
//        webView.getEngine().load(resourceUrl.toExternalForm());
//
//        // Ajustamos el tamaño para que se comporte como un icono
//        webView.setMaxSize(32, 24);
//        webView.setMinSize(32, 24);
//        webView.setPrefSize(32, 24);
//
//        // Desactivamos el menú contextual y las barras de desplazamiento para que parezca una imagen
//        webView.setContextMenuEnabled(false);
//
//        return webView;
//    }

}
