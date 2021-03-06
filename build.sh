#!/bin/bash
# Reference: https://getbootstrap.com/docs/4.0/components/modal/

start_doc() {
cat << "EOF"
<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

        <title>Verkehrsschilder</title>

        <style>
           .modal-backdrop {
                opacity:0.9 !important;
           } 
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row">
            <div class="col-12">
EOF

if [[ "$1" == de ]]; then
cat << EOF
                <h1>KI & Mobilität Beispielbilder</h1>
                <p><a class="btn btn-primary" href="${2}en/index.html">English Version</a></p>
                <p>Für diese Demo benötigst du einen Laptop/PC mit Webcam, sowie ein Smartphone, Tablet, oder einen Drucker, um Bilder von Verkehrsschildern auszudrucken, die wir dann später klassifizieren können.</p>
                <ul>
                    <li>Öffne <a href="https://teachablemachine.withgoogle.com/train/image" target="_blank">die Teachable Machine</a> auf deinem PC oder Tablet.</li>
                    <li>Zeichne Trainingsdaten auf, indem du die Bilder unten auf der Seite in die Kamera hältst. Achte dabei darauf, immer nur ein Bild zu zeigen. Dafür kannst du die Bilder durch anklicken vergrößern.</li>
                </ul>
EOF
fi

if [[ "$1" == en ]]; then
cat << EOF
            <div class="col-12">
                <h1>AI and Mobility Example Images</h1>
                <p><a class="btn btn-primary" href="$2de/index.html">German Version</a></p>
                <p>To use this demo, you need a laptop/computer with a webcam. You also need a smartphone, tablet or a printer. Below are some traffic signs we will use for building an image classication model.</p>
                <ul>
                    <li>Open <a href="https://teachablemachine.withgoogle.com/train/image" target="_blank">the Teachable Machine</a> on your computer.</li>
                    <li>Record training data of the traffic signs below. Each sign can be added as a single class. You can focus and enlarge the images by clicking on them.</li>
                </ul>
EOF
fi

cat << "EOF"
            </div>
            </div>
            <div class="row">
            <div class="col-12">
                <div class="card-group">
EOF
}

card_item() {
cat << EOF
                    <div class="card">
                        <a data-toggle="modal" data-target="#showImageModal" data-image="$1">
                            <img src="$1" class="card-img-top" alt="$1">
                        </a>
                    </div>
EOF
}

end_doc() {
cat << "EOF"
                </div>
            </div>
        </div>
        </div>

        <div class="modal fade" id="showImageModal" tabindex="-1" role="dialog" aria-labelledby="showImageModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body justify-center">
                        <img id="showImageModalImage" src="#" style="width: 100%">
                    </div>
                    <div class="modal-footer">
                    </div>
                </div>
            </div>
        </div>

        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script>
            $('#showImageModal').on('show.bs.modal', function (event) {
              var button = $(event.relatedTarget);
              var image = button.data('image');
              document.getElementById("showImageModalImage").src = image;
            })
        </script>
    </body>
</html>
EOF
}

build() {
start_doc $1 $2
for img in img/*.png; do
    card_item ${2}${img}
done
end_doc
}

mkdir -p docs/img
mkdir -p docs/de
mkdir -p docs/en
build de "" > docs/index.html
build de "../" > docs/de/index.html
build en "../" > docs/en/index.html
cp img/* docs/img
