package es.israeldelamo.transportes.controladores;

import es.israeldelamo.transportes.dao.DaoNaturalezaPeligrosa;
import es.israeldelamo.transportes.modelos.ModeloNaturalezasPeligrosas;
import es.israeldelamo.transportes.utilidades.LanzadorDeInformes;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.ComboBox;

/**
 * Una pantallita de 3 por 3 con los diferentes informes
 */
public class BotoneraInformesController {


    @FXML
    private ComboBox<String> cbOtrosInformes;


/**
     * Rellena los comboboxes de combo box una y otra vez, es un bloque refactorizado
     */
    private void relleneComboBoxListadoInformes() {
        cbOtrosInformes.getItems().clear();
        ObservableList<String> listadoDeInformesRestantes = FXCollections.observableArrayList();
        listadoDeInformesRestantes.addAll("ConductoresYSusVehiculos","TiposDeBultos","TiposDeVehiculos");
        cbOtrosInformes.setItems(listadoDeInformesRestantes);


    }


    @FXML
    void comb_listado_resto_informes_cambio() {
        System.out.println("comb_listado_resto_informes_cambio DISPARO");
        System.out.println(cbOtrosInformes.getSelectionModel().getSelectedItem().toString());
        LanzadorDeInformes.lanzadorDeInformes(cbOtrosInformes.getSelectionModel().getSelectedItem().toString());
    }



    /**
     * Lanza un Jasper Reports con un listado de todos los registros de la tabla Login
     */
    @FXML
    void crearInformeDeUltimos20CargasCreadas() {
        LanzadorDeInformes.lanzadorDeInformes("20UltimasCargasCreadas");

    }


    /**
     * Lanza un Jasper Reports con un listado de todos los registros de la tabla Login
     */
    @FXML
    void crearInformeDeLogins() {
        LanzadorDeInformes.lanzadorDeInformes("Logins");
    }

    /**
     * Lanza un Jasper Reports con un listado de todas las cargas por país de origen
     */
    @FXML
    void crearInformeDeCargasPorPaisOrigen() {
        LanzadorDeInformes.lanzadorDeInformes("CargasPorOrigen");
    }


    /**
     * Lanza un Jasper Reports con un listado de todos las cargas por país de destino
     */
    @FXML
    void crearInformeDeCargasPorPaisDestino() {
        LanzadorDeInformes.lanzadorDeInformes("CargasPorDestino");
    }

    /**
     * Lanza un Jasper Reports con el listado de todos los tipos de carnet
     */

    @FXML
    void crearInformeEnviosDetalle() {
        LanzadorDeInformes.lanzadorDeInformes("InformeEnviosDetalle");
    }


    /**
     * Lanza un JasperReports con un listado de todos las empresas de la base de datos
     */
    @FXML
    void crearInformeDeEmpresas() {
        LanzadorDeInformes.lanzadorDeInformes("Empresas");
    }


    /**
     * Lanza un JasperReports con un listado de todos los conductores y sus datos básicos
     */
    @FXML
    void crearInformeDeConductor() {
        LanzadorDeInformes.lanzadorDeInformes("Conductores");
    }

    @FXML
    public void initialize(){

        relleneComboBoxListadoInformes();
    }

}
