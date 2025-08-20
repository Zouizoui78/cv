node {
    cleanWs()
    checkout(scm)
    def img = docker.build("azouiten/chromium-headless:0.1", "--no-cache .")
    img.inside {
        sh 'chromium --headless --no-sandbox --print-to-pdf=cv_zouiten_en.pdf src/cv_zouiten_en.html'
    }
}
