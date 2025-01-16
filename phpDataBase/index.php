<!DOCTYPE html>
<html>

<body>
    <h3>Database World Operations</h3>

    <?php
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbName = "world";

    try {
        $conn = new PDO("mysql:host=$servername;dbname=$dbName", $username, $password);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        echo "Connected successfully<br>";

        echo "<h4>Visualizzazione dei dati della tabella 'city'</h4>";
        $sql = 'SELECT name, population, ID FROM city WHERE CountryCode="ITA"';
        $result_table = $conn->query($sql);

        echo '<table border="1">';
        foreach ($result_table as $row) {
            echo '<tr>';
            echo '<td>' . $row['name'] . '</td>';
            echo '<td>' . $row['population'] . '</td>';
            echo '<td>' . $row['ID'] . '</td>';
            echo '</tr>';
        }
        echo '</table>';

        if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['insert'])) {
            $city_name = $_POST['city_name'];
            $city_population = $_POST['city_population'];
            $insert_sql = "INSERT INTO city (name, population, CountryCode) VALUES ('$city_name', $city_population, 'ITA')";
            $conn->exec($insert_sql);
            echo "Record inserted successfully<br>";
        }

        if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['update'])) {
            $city_id = $_POST['city_id'];
            $new_population = $_POST['new_population'];
            $update_sql = "UPDATE city SET population = $new_population WHERE ID = $city_id";
            $conn->exec($update_sql);
            echo "Record updated successfully<br>";
        }

        if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['delete'])) {
            $city_id = $_POST['city_id_delete'];
            $delete_sql = "DELETE FROM city WHERE ID = $city_id";
            $conn->exec($delete_sql);
            echo "Record deleted successfully<br>";
        }

        // Form per l'inserimento
        echo '<h4>Inserire una nuova città</h4>';
        echo '<form method="post">';
        echo 'Nome città: <input type="text" name="city_name" required><br>';
        echo 'Popolazione: <input type="number" name="city_population" required><br>';
        echo '<input type="submit" name="insert" value="Inserisci">';
        echo '</form>';

        // Form per la modifica
        echo '<h4>Modificare la popolazione di una città</h4>';
        echo '<form method="post">';
        echo 'ID città: <input type="number" name="city_id" required><br>';
        echo 'Nuova popolazione: <input type="number" name="new_population" required><br>';
        echo '<input type="submit" name="update" value="Aggiorna">';
        echo '</form>';

        // Form per la cancellazione
        echo '<h4>Cancellare una città</h4>';
        echo '<form method="post">';
        echo 'ID città: <input type="number" name="city_id_delete" required><br>';
        echo '<input type="submit" name="delete" value="Cancella">';
        echo '</form>';

        $conn = null;
    } catch (PDOException $e) {
        echo "Connection failed: " . $e->getMessage();
    }
    ?>
</body>

</html>