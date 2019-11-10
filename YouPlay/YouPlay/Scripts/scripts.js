function verImagem() {
    var fReader = new FileReader();
    fReader.readAsDataURL(document.getElementById("Imagem").files[0]);
    fReader.onload = function (oFREvent) {
        document.getElementById("imgPreview").src = oFREvent.target.result;
    };
}

var alterarFoto = function (event) {
    var selectedFile = event.target.files[0];
    var reader = new FileReader();
    var imgtag = $(controles().fotoPessoa); //ID DA IMG 
    var ArquivoFoto = new Array();
    imgtag.title = selectedFile.name;
    reader.readAsDataURL(selectedFile);

    reader.onloadend = function () {
        $(controles().insertImage).empty(); //ID DA DIV QUE MANTEM A IMG
        $(controles().insertImage).append("<div class='moldura' style='background-image: url(" + reader.result + ");'></div>");
        ArquivoFoto = {
            Nome: selectedFile.name,
            ContentType: selectedFile.type,
            Conteudo: reader.result.slice(reader.result.indexOf(",") + 1)
        };
    }
}