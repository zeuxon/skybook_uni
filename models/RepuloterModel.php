<?php
require '../../config/connection.php';

class RepuloterModel {
    private $conn;

    public function __construct($conn) {
        $this->conn = $conn;
    }

    public function getAllAirports() {
        $stid = oci_parse($this->conn, 
        "SELECT * FROM Repuloter
                   ORDER BY repuloter_id");
        oci_execute($stid);
        $airports = [];
        while ($row = oci_fetch_assoc($stid)) {
            $airports[] = $row;
        }
        oci_free_statement($stid);
        return $airports;
    }

    public function getAirportById($id) {
        $stid = oci_parse($this->conn, "SELECT * FROM Repuloter WHERE repuloter_id = :id");
        oci_bind_by_name($stid, ':id', $id);
        oci_execute($stid);
        $airport = oci_fetch_assoc($stid);
        oci_free_statement($stid);
        return $airport;
    }

    public function getDepartureCounts() {
        $query = "SELECT r.repuloter_id, r.nev, COUNT(j.jaratid) AS indulasi_jaratok
                FROM Repuloter r
                LEFT JOIN Ut u ON r.repuloter_id = u.indulasi_repuloter_id
                LEFT JOIN Repulojarat j ON u.ut_id = j.ut_id
                GROUP BY r.repuloter_id, r.nev
                ORDER BY indulasi_jaratok DESC";
        $stid = oci_parse($this->conn, $query);
        oci_execute($stid);
        $result = [];
        while ($row = oci_fetch_assoc($stid)) {
            $result[] = $row;
        }
        oci_free_statement($stid);
        return $result;
    }

    public function getArrivalCounts() {
        $query = "SELECT r.repuloter_id, r.nev, COUNT(j.jaratid) AS erkezesi_jaratok
                FROM Repuloter r
                LEFT JOIN Ut u ON r.repuloter_id = u.erkezesi_repuloter_id
                LEFT JOIN Repulojarat j ON u.ut_id = j.ut_id
                GROUP BY r.repuloter_id, r.nev
                ORDER BY erkezesi_jaratok DESC";
        $stid = oci_parse($this->conn, $query);
        oci_execute($stid);
        $result = [];
        while ($row = oci_fetch_assoc($stid)) {
            $result[] = $row;
        }
        oci_free_statement($stid);
        return $result;
    }

    public function createAirport($nev, $varos, $orszag) {
        $stid = oci_parse($this->conn, "SELECT NVL(MAX(repuloter_id), 0) + 1 AS next_id FROM Repuloter");
        oci_execute($stid);
        $row = oci_fetch_assoc($stid);
        $nextId = $row['NEXT_ID'];
        oci_free_statement($stid);
    
        $stid = oci_parse($this->conn, "INSERT INTO Repuloter (repuloter_id, nev, varos, orszag) VALUES (:id, :nev, :varos, :orszag)");
        oci_bind_by_name($stid, ':id', $nextId);
        oci_bind_by_name($stid, ':nev', $nev);
        oci_bind_by_name($stid, ':varos', $varos);
        oci_bind_by_name($stid, ':orszag', $orszag);
        return oci_execute($stid);
    }

    public function updateAirport($id, $nev, $varos, $orszag) {
        $stid = oci_parse($this->conn, "UPDATE Repuloter SET nev = :nev, varos = :varos, orszag = :orszag WHERE repuloter_id = :id");
        oci_bind_by_name($stid, ':id', $id);
        oci_bind_by_name($stid, ':nev', $nev);
        oci_bind_by_name($stid, ':varos', $varos);
        oci_bind_by_name($stid, ':orszag', $orszag);
        return oci_execute($stid);
    }

    public function deleteAirport($id) {
        $stid = oci_parse($this->conn, "DELETE FROM Repuloter WHERE repuloter_id = :id");
        oci_bind_by_name($stid, ':id', $id);
        return oci_execute($stid);
    }
}
?>