def generate_pdf(String input, String output) {
    sh "chromium --headless --no-sandbox --print-to-pdf=$output $input"
}

def upload_file(String file, String url, String credentials) {
    sh "curl --fail-with-body -T $file -u $credentials $url"
}

node {
    cleanWs()
    checkout(scm)

    def img = docker.build("azouiten/chromium-headless:0.1")
    img.inside {
        generate_pdf("src/cv_zouiten_en.html", "cv_zouiten_en.pdf")
        generate_pdf("src/cv_zouiten_fr.html", "cv_zouiten_fr.pdf")
    }

    withCredentials([usernamePassword(credentialsId: 'cv-upload', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
        upload_file("cv_zouiten_en.pdf", "https://cv.zouizoui.ovh/api/cv_zouiten_en.pdf", "$USERNAME:$PASSWORD")
        upload_file("cv_zouiten_fr.pdf", "https://cv.zouizoui.ovh/api/cv_zouiten_fr.pdf", "$USERNAME:$PASSWORD")
    }
}
