<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Foglalás kezelése</title>
    <link rel="stylesheet" href="../../css/styles.css">
</head>
<body>
    <a href="../../index.php">Vissza</a>
    <h1>Foglalás kezelése</h1>
    <form method="POST" action="../../controllers/admin/FoglalasController.php">
        <label for="foglalas_id">Foglalás ID (csak módosításhoz/törléshez):</label>
        <input type="number" id="foglalas_id" name="foglalas_id"><br>
        
        <label for="felhasznalo_id">Felhasználó:</label>
        <select id="felhasznalo_id" name="felhasznalo_id" required>
            <?php foreach ($users as $user): ?>
                <option value="<?= htmlspecialchars($user['FELHASZNALO_ID']) ?>">
                    <?= htmlspecialchars($user['NEV']) ?>
                </option>
            <?php endforeach; ?>
        </select><br>
        
        <label for="jegy_id">Jegy:</label>
        <select id="jegy_id" name="jegy_id" required>
            <?php foreach ($tickets as $ticket): ?>
                <option value="<?= htmlspecialchars($ticket['JEGY_ID']) ?>">
                    <?= htmlspecialchars($ticket['JEGYKATEGORIA_NEV']) ?> - <?= htmlspecialchars($ticket['AR']) ?> Ft
                </option>
            <?php endforeach; ?>
        </select><br>
        
        <label for="datum">Dátum:</label>
        <input type="date" id="datum" name="datum" required><br>
        
        <label for="statusz">Státusz:</label>
        <select id="statusz" name="statusz" required>
            <option value="Fizetett">Fizetett</option>
            <option value="Fizetetlen">Fizetetlen</option>
            <option value="Függőben">Függőben</option>
            <option value="Törölve">Törölve</option>
        </select><br>
        
        <button type="submit" name="action" value="add">Hozzáadás</button>
        <button type="submit" name="action" value="edit">Módosítás</button>
        <button type="submit" name="action" value="delete">Törlés</button>
    </form>

    <h1>Foglalások</h1>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Felhasználó</th>
                <th>Jegy</th>
                <th>Dátum</th>
                <th>Státusz</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($bookings as $booking): ?>
                <tr>
                    <td><?= htmlspecialchars($booking['FOGLALAS_ID']) ?></td>
                    <td><?= htmlspecialchars($booking['FELHASZNALO_NEV']) ?></td>
                    <td><?= htmlspecialchars($booking['JEGYKATEGORIA_NEV']) ?> - <?= htmlspecialchars($booking['JEGY_AR']) ?> Ft</td>
                    <td><?= htmlspecialchars($booking['DATUM']) ?></td>
                    <td><?= htmlspecialchars($booking['STATUSZ']) ?></td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</body>
</html>