package UsoDiJDBC;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

public class Main {
    static final String DB_URL = "jdbc:mysql://localhost/personejdbc";
    static final String USER = "root";
    static final String PASS = "";

    public static void main(String[] args) {
        Connection conn = null;
        Statement stmt = null;
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            stmt = conn.createStatement();

            while (true) {
                System.out.println();
                System.out.println();
                System.out.println("Gestione Database, inserisci un commando:");
                System.out.println("    1. Inserisci un dato");
                System.out.println("    2. Modifica un dato");
                System.out.println("    3. Cancella un dato");
                System.out.println("    4. Visualizza tutti i dati");
                System.out.println("    9. Esci");

                String command = bufferedReader.readLine();

                switch (command) {
                    case "1":
                        System.out.println("Inserisci un dato selezionato.");
                        System.out.println("Inserisci il nome:");
                        String nome = bufferedReader.readLine();
                        System.out.println("Inserisci il cognome:");
                        String cognome = bufferedReader.readLine();
                        System.out.println("Inserisci l'età:");
                        String eta = bufferedReader.readLine();

                        String sqlId = "SELECT id FROM persona";
                        ResultSet rsId = stmt.executeQuery(sqlId);

                        int lastid = 0;
                        while (rsId.next()) {
                            int id = rsId.getInt("id");
                            if (id != lastid + 1) {
                                break;
                            }
                            lastid = id;
                        }
                        lastid++;

                        String sql = "INSERT INTO persona (id, nome, cognome, eta) VALUES (" + lastid + ", '" + nome
                                + "', '"
                                + cognome
                                + "', " + eta + ")";
                        stmt.executeUpdate(sql);

                        System.out.println("Dato inserito correttamente.");
                        break;
                    case "2":
                        System.out.println("Modifica un dato selezionato.");

                        System.out.println("Inserisci l'ID del dato da modificare:");
                        String id = bufferedReader.readLine();
                        System.out.println("Inserisci il nome:");
                        nome = bufferedReader.readLine();
                        System.out.println("Inserisci il cognome:");
                        cognome = bufferedReader.readLine();
                        System.out.println("Inserisci l'età:");
                        eta = bufferedReader.readLine();
                        sql = "UPDATE persona SET nome = '" + nome + "', cognome = '" + cognome + "', eta = " + eta
                                + " WHERE id = " + id;
                        stmt.executeUpdate(sql);

                        System.out.println("Dato modificato correttamente.");

                        break;
                    case "3":
                        System.out.println("Cancella un dato selezionato.");
                        System.out.println("Inserisci l'ID del dato da cancellare:");
                        id = bufferedReader.readLine();
                        sql = "DELETE FROM persona WHERE id = " + id;
                        stmt.executeUpdate(sql);

                        System.out.println("Dato cancellato correttamente.");
                        break;
                    case "4":
                        System.out.println("Visualizza tutti i dati.");
                        sql = "SELECT * FROM persona";
                        ResultSet rs = stmt.executeQuery(sql);

                        while (rs.next()) {
                            int idV = rs.getInt("id");
                            String nomeV = rs.getString("nome");
                            String cognomeV = rs.getString("cognome");
                            int etaV = rs.getInt("eta");

                            System.out.println(
                                    "ID: " + idV + ", Nome: " + nomeV + ", Cognome: " + cognomeV + ", Età: " + etaV);
                        }
                        break;
                    case "9":
                        System.out.println("Uscita dal programma.");
                        return;
                    default:
                        System.out.println("Comando non riconosciuto.");
                        break;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null)
                    stmt.close();
                if (conn != null)
                    conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}