package es.israeldelamo.transportes.controladores;

import es.israeldelamo.transportes.dao.DaoPaisYProvinciaYLocalidad;
import es.israeldelamo.transportes.dao.DaoPaisYProvinciaYLocalidadYCodigoPostal;
import es.israeldelamo.transportes.modelos.ModeloPaisYProvinciaYLocalidad;
import es.israeldelamo.transportes.modelos.ModeloPaisYProvinciaYLocalidadYCodigoPostal;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableRow;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.input.MouseButton;
import javafx.stage.Stage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.net.URL;
import java.util.ResourceBundle;

/**
 * Esta clase se usa para seleccionar entradas de Pais, provincia y Codigo postal sin importar que existan en envios o en
 * cualquier otro sitio
 * <p>
 * Accede a la tabla pública del padre para rellenar la información de vuelta.
 *
 * @author israel
 * @version $Id: $Id
 */
public class SeleccionOrigenesController implements Initializable {
    /**
     * Logger para esta clase
     */
    private static final Logger logger = LoggerFactory.getLogger(SeleccionOrigenesController.class);

    private ModeloPaisYProvinciaYLocalidad paisYProvinciaYLocalidadSeleccionadoTemporalDesdeDobleClick;


    // @FXML
    // private Button btn_cerrar;

    @FXML
    private TableColumn<ModeloPaisYProvinciaYLocalidad, String> tc_pais_tv_origenes;
    @FXML
    private TableColumn<ModeloPaisYProvinciaYLocalidad, String> tc_provincia_tv_origenes;
    @FXML
    private TableColumn<ModeloPaisYProvinciaYLocalidad, String> tc_localidad_tv_origenes;
    @FXML
    private TableView<ModeloPaisYProvinciaYLocalidad> tv_origenes;

    /**
     * Cierra la ventana modal de manera ordenada
     */
    @FXML
    void cerrarVentana() {
        Stage stage = (Stage) tv_origenes.getScene().getWindow();
        stage.close();
    }


    /**
     * Rellena la tabla de paises provincias  con el dao de PaisesProvincias
     */
    @FXML
    void mostrarTablaPaisesYProvincias() {


        tc_provincia_tv_origenes.setCellValueFactory(new PropertyValueFactory<>("provincia"));
        tc_localidad_tv_origenes.setCellValueFactory(new PropertyValueFactory<>("localidad"));
        tc_pais_tv_origenes.setCellValueFactory(new PropertyValueFactory<>("pais"));
        tv_origenes.getItems()
                .clear();
        tv_origenes.getItems()
                .addAll(DaoPaisYProvinciaYLocalidad.cargarListadoLocalidades());
        tv_origenes.refresh();
    }


    /**
     * Función que añade el doble clic a la tableview paises y provincias
     */
    private void funcionDobleClickParaTableViewPaisesYProvinciasYLocalidades() {

        tv_origenes.setRowFactory(tv -> {
            TableRow<ModeloPaisYProvinciaYLocalidad> row = new TableRow<>();
            row.setOnMouseClicked(event -> {
                if (!row.isEmpty() && event.getButton() == MouseButton.PRIMARY && event.getClickCount() == 2) {
                    paisYProvinciaYLocalidadSeleccionadoTemporalDesdeDobleClick = row.getItem();

                    //ahora hay que pasarla a la tabla GestionVehiculoController
                    GestionVehiculoController.daoPaisesYProvinciasYLocalidades_origenes_seleccionados
                            .add(new ModeloPaisYProvinciaYLocalidad(
                                    paisYProvinciaYLocalidadSeleccionadoTemporalDesdeDobleClick.getPais(),
                                    paisYProvinciaYLocalidadSeleccionadoTemporalDesdeDobleClick.getProvincia(),
                                    paisYProvinciaYLocalidadSeleccionadoTemporalDesdeDobleClick.getLocalidad()));

                    cerrarVentana();
                }
            });
            return row;
        });
    }

    /**
     * {@inheritDoc}
     * <p>
     * Clase de inicialización
     */
    @Override
    public void initialize(URL location, ResourceBundle resources) {
        mostrarTablaPaisesYProvincias();
        funcionDobleClickParaTableViewPaisesYProvinciasYLocalidades();
        // GestionVehiculoController.daoPaisesYProvinciasYLocalidades_origenes_Seleccionados.clear();

    }

}
