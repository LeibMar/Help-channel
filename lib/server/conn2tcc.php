<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "app-tcc";
$table = "postagem";
echo('servidor backend');
// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Retrieve data from Flutter POST request
//$postData = json_decode(file_get_contents('php://input'), true);
//$text = $postData['text']; // Assuming text is the key sent from Flutter




$text = $_POST['text'];


// Insert data into 'postagem' table
//$sql = "INSERT INTO postagem (textoPostagem) VALUES ('$text')";

// Insert data into 'postagem' table
$sql = "INSERT INTO postagem (textoPostagem, arquivoPostagem1, arquivoPostagem2, arquivoPostagem3, arquivoPostagem4) VALUES (?, ?, ?, ?, ?);";

$stmt = $conn->prepare($sql);
$stmt->bind_param("sssss", $text, $file1, $file2, $file3, $file4);

$uploadDir = "C:/xampp/htdocs/uploads/"; // Directory to store uploads

for ($i = 0; $i < 4; $i++) {
    if ($_FILES["file$i"]["error"] == UPLOAD_ERR_OK) {
        $tempName = $_FILES["file$i"]["tmp_name"];
        $fileName = basename($_FILES["file$i"]["name"]);
        $uploadPath = $uploadDir . $fileName;

        if (move_uploaded_file($tempName, $uploadPath)) {
            // File uploaded successfully
            ${"file" . ($i + 1)} = $uploadPath; // Set file path in corresponding variable
        } else {
            // Error uploading file
            ${"file" . ($i + 1)} = ""; // Set empty string if upload fails
        }
    } else {
        // No file uploaded or error occurred
        ${"file" . ($i + 1)} = ""; // Set empty string if no file or error occurs
    }
}

// Execute SQL statement
$stmt->execute();


if ($conn->query($sql) === TRUE) {
    echo "New record created successfully";
    
} 
else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
