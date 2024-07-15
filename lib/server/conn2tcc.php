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
//$text = $postData['text']; 




$text = $_POST['text'];


// Insert data into 'postagem' table
//$sql = "INSERT INTO postagem (textoPostagem) VALUES ('$text')";

// Insert data into 'postagem' table
$sql = "INSERT INTO postagem (textoPostagem, arquivoPostagem1, arquivoPostagem2, arquivoPostagem3, arquivoPostagem4) VALUES (?, ?, ?, ?, ?);";

$stmt = $conn->prepare($sql);
$stmt->bind_param("sssss", $text, $file1, $file2, $file3, $file4);

$uploadDir = "C:/xampp/htdocs/uploads/"; //Diretório para guardar os arquivos salvos, mude de acordo com o nome da sua pasta, de preferência a pasta deve esta dentro de htdcos

for ($i = 0; $i < 4; $i++) {
    if ($_FILES["file$i"]["error"] == UPLOAD_ERR_OK) {
        $tempName = $_FILES["file$i"]["tmp_name"];
        $fileName = basename($_FILES["file$i"]["name"]);
        $uploadPath = $uploadDir . $fileName;

        if (move_uploaded_file($tempName, $uploadPath)) {
            // File uploaded successfully
            ${"file" . ($i + 1)} = $uploadPath; 
        } else {
            // Error uploading file
            ${"file" . ($i + 1)} = ""; 
        }
    } else {
       
        ${"file" . ($i + 1)} = ""; 
    }
}

// Execute SQL statement
$stmt->execute();


if ($conn->query($sql) === TRUE) {
    echo "Postagem feita com sucesso";
    
} 
else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
