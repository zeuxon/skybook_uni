<?php
require '../../controllers/AdminCheckController.php';
require '../../models/FoglalasModel.php';
require '../../models/JegyModel.php';
require '../../config/connection.php';

if (!isset($_SESSION['username']) || !isAdmin($_SESSION['username'])) {
    header("HTTP/1.1 403 Forbidden");
    echo "Ehhez az oldalhoz nincs jogosultsága. <br> <a href='../../index.php'>Vissza a főoldalra</a>";
    exit();
}

$foglalasModel = new FoglalasModel($conn);
$jegyModel = new JegyModel($conn);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'];
    $id = $_POST['foglalas_id'] ?? null;
    $felhasznalo_id = $_POST['felhasznalo_id'];
    $jegy_id = $_POST['jegy_id'];
    $datum = $_POST['datum'];
    $statusz = htmlspecialchars($_POST['statusz']);

    if ($action === 'add') {
        $success = $foglalasModel->createBooking($felhasznalo_id, $datum, $statusz);
    } elseif ($action === 'edit' && $id) {
        $success = $foglalasModel->updateBooking($id, $felhasznalo_id, $datum, $statusz);
    } elseif ($action === 'delete' && $id) {
        $success = $foglalasModel->deleteBooking($id);
    }

    if ($success) {
        header('Location: ../../controllers/admin/FoglalasController.php');
    } else {
        echo "Operation failed.";
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $bookings = $foglalasModel->getAllBookings();
    $users = $foglalasModel->getAllUsers();
    $tickets = $jegyModel->getAllTickets();
    include '../../views/admin/foglalas.php';
}
?>