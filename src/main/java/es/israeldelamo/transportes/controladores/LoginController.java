package es.israeldelamo.transportes.controladores;



import es.israeldelamo.tiledcarga.TiledCarga;
import es.israeldelamo.transportes.Iniciografico;
import es.israeldelamo.transportes.dao.DaoLogin;
import es.israeldelamo.transportes.modelos.ModeloCargaYEntrega;
import es.israeldelamo.transportes.modelos.ModeloLogin;
import es.israeldelamo.transportes.utilidades.Alertas;
import es.israeldelamo.transportes.utilidades.EsperaDialog;
import es.israeldelamo.transportes.utilidades.FlagUtils;
import javafx.application.Platform;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.image.Image;

import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.TilePane;
import javafx.stage.Modality;
import javafx.stage.Stage;
import org.kordamp.bootstrapfx.BootstrapFX;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
import java.util.Locale;

import java.util.Optional;
import java.util.ResourceBundle;
import java.util.prefs.Preferences;

import static es.israeldelamo.transportes.dao.DaoCargaYEntrega.cargarListadoEntregaYCargaParaTiledPane;
import static es.israeldelamo.transportes.utilidades.ConversorDataPickerTimeStamp.DeTimeStampToString;
import static es.israeldelamo.transportes.utilidades.Video.reproducirVideo;

/**
 * Una clase que controla la pantalla de Login
 *
 * @author israel
 * @version $Id: $Id
 */
public class LoginController implements Initializable {

    /**
     * es la variable donde guardaremos el identificador del codigo de Reserva
     */
    private int elCodigoDeLaReserva;


    /**
     * Logger para esta clase
     */
    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

    /**
     * Referencia a la escena actual para poder indicar e padre en cada caso
     */
    private Stage stage;
    /**
     * Botón para salir de la aplicación
     */
    @FXML
    private Button btn_salir;
    /**
     * Campo de contraseña
     */
    @FXML
    private PasswordField fld_passw;
    /**
     * Campo de usuario
     */
    @FXML
    private TextField fld_user;


    /**
     * Contiene un panel pequeño por cada pedido en curso
     */
    @FXML
    private TilePane tp_pedidos;


    @FXML
    private TiledCarga tiledcarga;

    /**
     * El bundle de idiomas para este controlador
     */
    private static ResourceBundle bundle;

    /**
     * El listado de pedidos Tiled
     */
    private static ObservableList<ModeloCargaYEntrega> listadoCargasYEntregasTiled;





    /**
     * Carga el bundle de idiomas para que aparezcan las traducciones
     * podriamos haberlo traido de la clase anterior?
     */
    private void cargarBundleIdiomas(){
        // Cargar el idioma seleccionado
        Preferences prefs = Preferences.userNodeForPackage(LoginController.class);
        String idioma = prefs.get("textos", "es"); // Valor por defecto "es"
        Locale locale = Locale.forLanguageTag(idioma);
        bundle = ResourceBundle.getBundle("textos", locale);
    }
    /**
     * Abre el mp4 de tutorial de ADMINISTRADOR
     */
    @FXML
    void abrirTutorialAdm() {
        reproducirVideo("administrador", stage);
    }

    /**
     * Abre el mp4 de tutorial de CONDUCTOR

     */
    @FXML
    void abrirTutorialCnd() {
        reproducirVideo("conductor", stage);
    }

    /**
     * Abre el mp4 de tutorial de GESTOR

     */
    @FXML
    void abrirTutorialGst() {
        reproducirVideo("gestor", stage);
    }

    /**
     * Función que añade el doble clic a la tableview Envios
     *
     * @author israel
     */
    @FXML
    private void logeoAdministrador() {
        logger.info("Intentando entrar en administrador");
        if (validarLogin("administrador")) {
            abreLaVentanaDe("gestionAdministrador");
        }
    }

    /**
     * Intenta conectarse como Conductor
     *
     * @author israel
     */
    @FXML
    void logueoConductor() {
        logger.info("Intentando entrar en Coductor");
        if (validarLogin("conductor")) {
            abreLaVentanaDe("gestionVehiculo");
        }
    }

    /**
     * Intenta conectarse como gestor
     *
     * @author israel
     */
    @FXML
    void logueoGestor() {
        logger.info("Intentando entrar en gestor");
        if (validarLogin("gestor")) {
            abreLaVentanaDe("gestionGerente");
        }
    }

    /**
     * Lee la base de datos para ver si existe ese login con ese rol
     *
     * @param tipoDeRol el papel que va a desempeñar el usuario
     * @return true si el login es válido, false si no lo es
     * @author israel
     */
    boolean validarLogin(String tipoDeRol) {
        ModeloLogin milogin = new ModeloLogin(fld_user.getText(), fld_passw.getText(), tipoDeRol);
        try {
            if (DaoLogin.cargarListadoLogins().contains(milogin)) {
                return true;
            } else {
                Alertas alertaError = new Alertas();
                alertaError.mostrarError("No he encontrado esos datos de inicio de sesión");
                logger.error("Error de inicio de sesión");
            }
        } catch (SQLException e) {
            Alertas alertas = new Alertas();
            alertas.mostrarError("Fallo catastrófico de conexión");
        }
        return false;
    }

    /**
     * Abre una ventana en función del nombre de la ventana. Solo puede ser la de admin, conductor o gestor
     *
     * @param elNombreDeLaVentana el nombre de la ventana a abrir
     * @author israel
     */
    private void abreLaVentanaDe(String elNombreDeLaVentana) {
        //preparo los idiomas del bundle
        cargarBundleIdiomas();

        // Guarda la referencia de la ventana principal
        //Stage currentStage = (Stage) btn_salir.getScene().getWindow();
        String elUsuario = fld_user.getText();  // Obtiene el usuario desde el campo de texto

        try {
            // Cargar el archivo FXML correspondiente


            // Aquí puedes crear una instancia del controlador manualmente
            if (elNombreDeLaVentana.equals("gestionVehiculo")) {
                // Mostrar diálogo de espera y diferir la carga para permitir que se pinte
                Stage owner = (Stage) btn_salir.getScene().getWindow();
                Stage waitDialog = EsperaDialog.mostrar(owner,
                        bundle != null ? bundle.getString("cargando_datos") : "Cargando datos...");

                Platform.runLater(() -> {
                    try {
                        FXMLLoader loader = new FXMLLoader(Iniciografico.class.getResource("fxml/" + elNombreDeLaVentana + ".fxml"), bundle);

                        Parent root = loader.load();
//                        GestionVehiculoController controlador = loader.getController();
//                        controlador.pasoDeParametros(elUsuario);

                        Scene scene = new Scene(root);
                        Stage newStage = new Stage();
                        newStage.initModality(Modality.APPLICATION_MODAL);
                        newStage.initOwner(owner);

                        Image icono = new Image(String.valueOf(getClass().getResource("/es/israeldelamo/transportes/imagenes/icono.png")));
                        newStage.getIcons().add(icono);

                        newStage.setScene(scene);
                        newStage.setResizable(true);
                        newStage.setMaximized(true);
                        newStage.setTitle("");

                        GestionVehiculoController controladorVehiculo = loader.getController();
                        controladorVehiculo.initialize(elUsuario);

                        EsperaDialog.cerrar(waitDialog);
                        newStage.showAndWait();
                    } catch (IOException e) {
                        EsperaDialog.cerrar(waitDialog);
                        Alertas alertaError = new Alertas();
                        alertaError.mostrarError("No se pudo abrir la ventana de Vehículos: " + e.getMessage());
                    } finally {
                        EsperaDialog.cerrar(waitDialog);
                    }
                });
            }
            // De forma similar para las otras ventanas
            else if (elNombreDeLaVentana.equals("gestionGerente")) {
                // Mostrar diálogo de espera y diferir la carga para permitir que se pinte
                Stage owner = (Stage) btn_salir.getScene().getWindow();
                Stage waitDialog = EsperaDialog.mostrar(owner,
                        bundle != null ? bundle.getString("cargando_datos") : "Cargando datos...");

                Platform.runLater(() -> {
                    try {
                        FXMLLoader loader = new FXMLLoader(Iniciografico.class.getResource("fxml/" + elNombreDeLaVentana + ".fxml"), bundle);

                        Parent root = loader.load();
                        GestionGerenteController controlador = loader.getController();
                        controlador.pasoDeParametros(elUsuario);

                        Scene scene = new Scene(root);
                        Stage newStage = new Stage();
                        newStage.initModality(Modality.APPLICATION_MODAL);
                        newStage.initOwner(owner);

                        Image icono = new Image(String.valueOf(getClass().getResource("/es/israeldelamo/transportes/imagenes/icono.png")));
                        newStage.getIcons().add(icono);

                        newStage.setScene(scene);
                        newStage.setResizable(true);
                        newStage.setMaximized(true);
                        newStage.setTitle("");

                        GestionGerenteController controladorGerente = loader.getController();
                        controladorGerente.initialize(elUsuario);

                        EsperaDialog.cerrar(waitDialog);
                        newStage.showAndWait();
                    } catch (IOException e) {
                        EsperaDialog.cerrar(waitDialog);
                        Alertas alertaError = new Alertas();
                        alertaError.mostrarError("No se pudo abrir la ventana de Gerente: " + e.getMessage());
                    } finally {
                        EsperaDialog.cerrar(waitDialog);
                    }
                });



}



                // De forma similar para las otras ventanas
            else if (elNombreDeLaVentana.equals("crearEnvio")) {
                    // Mostrar diálogo de espera y diferir la carga para permitir que se pinte
                    Stage owner = (Stage) btn_salir.getScene().getWindow();
                    Stage waitDialog = EsperaDialog.mostrar(owner,
                            bundle != null ? bundle.getString("cargando_datos") : "Cargando datos...");

                    Platform.runLater(() -> {
                        try {
                            FXMLLoader loader = new FXMLLoader(Iniciografico.class.getResource("fxml/" + elNombreDeLaVentana + ".fxml"), bundle);

                            Parent root = loader.load();
//                            CrearEnvioController controlador = loader.getController();
//                            controlador.pasoDeParametros(elCodigoDeLaReserva);

                            Scene scene = new Scene(root);
                            Stage newStage = new Stage();
                            newStage.initModality(Modality.APPLICATION_MODAL);
                            newStage.initOwner(owner);

                            Image icono = new Image(String.valueOf(getClass().getResource("/es/israeldelamo/transportes/imagenes/icono.png")));
                            newStage.getIcons().add(icono);

                            newStage.setScene(scene);
                            newStage.setResizable(true);
                            newStage.setMaximized(true);
                            newStage.setTitle("");

                            CrearEnvioController controladorEnvio = loader.getController();
                            //el creadorEnvio controller puede inicalizarse con el dato del conductor que lo pulso
                            //controladorEnvio.initialize(elUsuario)
                            //como no filtramos por el sql, le pasamos false,un sql vacio y el código a mostrar
                            controladorEnvio.inicializarLaEscenaConDatosPasados(elUsuario,"", false, elCodigoDeLaReserva);

                            EsperaDialog.cerrar(waitDialog);
                            newStage.showAndWait();
                        } catch (IOException e) {
                            EsperaDialog.cerrar(waitDialog);
                            Alertas alertaError = new Alertas();
                            alertaError.mostrarError("No se pudo abrir la ventana de CrearEnvio desde el tilepane: " + e.getMessage());
                        } finally {
                            EsperaDialog.cerrar(waitDialog);
                        }
                    });















                } else if (elNombreDeLaVentana.equals("gestionAdministrador")) {
                // Mostrar diálogo de espera mientras se prepara la ventana
                Stage owner = (Stage) btn_salir.getScene().getWindow();
                Stage waitDialog = EsperaDialog.mostrar(owner,
                        bundle != null ? bundle.getString("cargando_datos") : "Cargando datos...");

                // IMPORTANTE: diferimos el trabajo pesado al siguiente ciclo del bucle de eventos
                // para que el diálogo tenga tiempo de renderizarse antes de bloquear con la carga.
                Platform.runLater(() -> {
                    try {
                        FXMLLoader loader = new FXMLLoader(Iniciografico.class.getResource("fxml/" + elNombreDeLaVentana + ".fxml"), bundle);

                        Parent root = loader.load();
                        GestionAdministradorController controlador = loader.getController();
                        controlador.pasoDeParametros(elUsuario);

                        Scene newScene = new Scene(root);
                        newScene.getStylesheets().add(BootstrapFX.bootstrapFXStylesheet());

                        Stage newStage = new Stage();
                        newStage.initModality(Modality.APPLICATION_MODAL);
                        newStage.initOwner(owner);
                        newStage.setScene(newScene);
                        newStage.setTitle("");
                        Image icono = new Image(String.valueOf(getClass().getResource("/es/israeldelamo/transportes/imagenes/icono.png")));
                        newStage.getIcons().add(icono);

                        newStage.setResizable(true);
                        newStage.setMaximized(true);

                        GestionAdministradorController controladorAdmin = loader.getController();
                        // Le paso el usuario, en principio un conductor
                        controladorAdmin.initialize(elUsuario);

                        // Cerrar diálogo de espera justo antes de mostrar la ventana
                        EsperaDialog.cerrar(waitDialog);
                        newStage.showAndWait();
                    } catch (IOException e) {
                        // Si algo falla, cerramos el diálogo y mostramos error
                        EsperaDialog.cerrar(waitDialog);
                        Alertas alertaError = new Alertas();
                        alertaError.mostrarError("No se pudo abrir la ventana de Administración: " + e.getMessage());
                    } finally {
                        EsperaDialog.cerrar(waitDialog);
                    }
                });


            } else if (elNombreDeLaVentana.equals("VisorAyuda")) {
                FXMLLoader loader = new FXMLLoader(Iniciografico.class.getResource("fxml/" + elNombreDeLaVentana + ".fxml"),bundle);

                Parent root = loader.load();


                Scene newScene = new Scene(root);
                newScene.getStylesheets().add(BootstrapFX.bootstrapFXStylesheet());

                Stage newStage = new Stage();
                newStage.setScene(newScene);
                newStage.setTitle(elNombreDeLaVentana);
                Image icono = new Image(String.valueOf(getClass().getResource("/es/israeldelamo/transportes/imagenes/icono.png")));
                newStage.getIcons().add(icono);
                newStage.setResizable(false);
                newStage.setMaximized(true);
                newStage.showAndWait();


            }


        } catch (IOException e) {
            // Mostrar un error si ocurre una excepción al cargar la ventana
            Alertas alertaError = new Alertas();
            alertaError.mostrarError("Fallo al lanzar la ventana solicitada " + elNombreDeLaVentana);
            alertaError.mostrarError(e.getMessage());
        }
    }

    /**
     * {@inheritDoc}
     *
     * @author israel
     */
    @Override
    public void initialize(URL location, ResourceBundle resources) {
        //Foco inicial sobre el campo de nombre
        Platform.runLater(() -> fld_user.requestFocus());
        cargarBundleIdiomas();
        rellenarPanelDePedidos();

    }





    void rellenarPanelDePedidos(){
        // Configurar propiedades del TilePane
        tp_pedidos.setHgap(10);
        tp_pedidos.setVgap(10);
        // Eliminar el prefColumns fijo para permitir redimensionamiento automático
        //los guardo en un sitio temporal
        recuperarPedidosParaPanel();
        //creo un conjunto de paneles a partir de los datos recuperados
        crearTodosLosPedidos();
        //cambio el panel de pedidos con el nuevo contenido
        //cronómetro de consultas

    }

    /**
     * Carga y llamada al DAO
     */
    void recuperarPedidosParaPanel(){

        listadoCargasYEntregasTiled = cargarListadoEntregaYCargaParaTiledPane();

    }


    void crearTodosLosPedidos() {
        crearPanelConPedido();
    }



    /**
     * Por cada elemento del observable list crea un tiledCarga y lo añade
     */
    void crearPanelConPedido(){
        //por cada elemento de listadoCargasYEntregaTiled y hasta llegar al final crear un pedido
        // Eliminar los elementos existentes del TilePane antes de agregar nuevos
        tp_pedidos.getChildren().clear();
        
        // Recorrer cada elemento en el listado y crear un nuevo TiledCarga para cada uno
        if (listadoCargasYEntregasTiled != null) {
            for (ModeloCargaYEntrega carga : listadoCargasYEntregasTiled) {
                try {
                    // Crear una nueva instancia de TiledCarga
                    TiledCarga nuevoTiledCarga = new TiledCarga();

                    nuevoTiledCarga.getStyleClass().add("tiled-carga");
                    
                    // Configurar las propiedades del nuevo TiledCarga
                    nuevoTiledCarga.setLb_pais_destino(carga.getPais_destino().toUpperCase(Locale.ROOT));
                    nuevoTiledCarga.setLb_pais_origen(carga.getPais_origen().toUpperCase(Locale.ROOT));
                    nuevoTiledCarga.getLb_pais_destino().getStyleClass().add("tiled-carga-label");
                    nuevoTiledCarga.getLb_pais_origen().getStyleClass().add("tiled-carga-label");
                    nuevoTiledCarga.setLb_provincia_destino(carga.getProvincia_destino());
                    nuevoTiledCarga.setLb_provincia_origen(carga.getProvincia_origen());

//                    // el volumen es el producto de todas las partes
                    float volumen = carga.getDimension_a()*carga.getDimension_h()*carga.getDimension_l();//
                    nuevoTiledCarga.setLb_dimension(String.valueOf(volumen/1000000)+"m³");

//                    // si es carga completa o no que aparezca
                    String camion = carga.getCarga_completa_o_grupaje()?"Carga completa":"Grupaje";
                    nuevoTiledCarga.setLb_carga_completa_o_grupaje(camion);
//
                 //ahora las banderitas
                    Image banderaDestino = FlagUtils.getFlagPNG(carga.getPais_destino());
                    nuevoTiledCarga.setIv_pais_destino(banderaDestino);

                  Image banderaOrigen = FlagUtils.getFlagPNG(carga.getPais_origen());
                   nuevoTiledCarga.setIv_pais_origen(banderaOrigen);

                   //zzona de fechas
                    if (carga.getFecha_creaccion() == null) {
                      logger.error("FECHA NO VALIDA");
                    }
                    else
                    {
                        String[] partes = DeTimeStampToString(carga.getFecha_creaccion()).split(" ");
                        nuevoTiledCarga.setLb_fecha_creaccion(String.format("Creada el: %s   %s horas",
                                partes[0], partes[1]));

                    }

                    // nuevoTiledCarga.setLb_nombre_bulto("carga.getNombre_bulto()");
                    //System.out.println(carga.getNombre_bulto());

                    //peso unitario y cantidad de bultos
                    nuevoTiledCarga.setLb_cantidad_bultos(String.valueOf(carga.getCantidad_bultos())+"  "+carga.getNombre_bulto());
                    nuevoTiledCarga.setLb_peso_unitario(String.valueOf(carga.getPeso_unitario()*carga.getCantidad_bultos()/1000)+"Tm");
                    nuevoTiledCarga.getBtn_reservar().setOnAction(e -> {
                        System.out.println(carga.getCod_carga());
                        elCodigoDeLaReserva = carga.getCod_carga();
                        abreLaVentanaDe("crearEnvio");

                    });
                    
                    // Apply the same styling as other buttons in the login screen
                    nuevoTiledCarga.getBtn_reservar().getStyleClass().add("tiled-carga-button");

                    
                    // Añadir el nuevo TiledCarga al TilePane
                    tp_pedidos.getChildren().add(nuevoTiledCarga);
                    
                } catch (Exception e) {
                    logger.error("Error al crear TiledCarga para pedido: " + carga.toString(), e);
                }
            }
        }
    }



    void logueoConductorConCodCarga() {
        logger.info("Intentando entrar en Coductor con una carga para pedido");
        if (validarLogin("conductor")) {
            abreLaVentanaDe("crearEnvio");
        }
    }


    /**
     * Muestra la ventana de ayuda
     *
     * @author israel
     */
    @FXML
    void mostrarAyuda() {
        abreLaVentanaDe("VisorAyuda");
    }

    /**
     * Cierra la aplicación
     *
     * @author israel
     */
    @FXML
    void salirDeLaApp() {
        Alertas alerta = new Alertas();
        logger.info("INFO intenta salir de la app");
        Optional<ButtonType> action = alerta.mostrarAlertaConfirmacion("¿Salir?", "Abandonando la aplicación");
        if (action.isPresent() && action.get() == ButtonType.OK) {
            Platform.exit();
        }



    }
}