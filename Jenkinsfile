node {
    cleanWs()
    checkout(scm)
    def img = docker.build("azouiten/chromium-headless:0.1")
    img.inside {
        sh 'chromium --headless --no-sandbox --print-to-pdf=cv_zouiten_en.pdf src/cv_zouiten_en.html'
        sh 'chromium --headless --no-sandbox --print-to-pdf=cv_zouiten_fr.pdf src/cv_zouiten_fr.html'
    }
}
