function verImagem() {
    var oFReader = new FileReader();
    oFReader.readAsDataURL(document.getElementById("Imagem").files[0]);
    oFReader.onload = function (oFREvent) {
        document.getElementById("fotoPessoa").src = oFREvent.target.result;
    };
}