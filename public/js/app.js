$(document).ready(function() {
    $(".cssload-thecube").css("display", "none");

    $("#submit").click(function() {
        $(".cssload-thecube").css("display", "block");
        $(".main-content").css("display", "none");
    });

    var modal = document.getElementById('myModal');
    var modalImg = document.getElementById("img01");
    $('.myImg').click(function() {
        modal.style.display = "block";
        modalImg.src = this.src;
        captionText.innerHTML = this.alt;
    });

    // Get the <span> element that closes the modal



    var span = document.getElementsByClassName("close")[0];

    // When the user clicks on <span> (x), close the modal
    span.onclick = function() {
        modal.style.display = "none";
    }
});