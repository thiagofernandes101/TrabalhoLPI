function verImagem() {
    var fReader = new FileReader();
    fReader.readAsDataURL(document.getElementById("Imagem").files[0]);
    fReader.onload = function (oFREvent) {
        document.getElementById("imgPreview").src = oFREvent.target.result;
    };
}