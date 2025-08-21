node {
    cleanWs()
    checkout(scm)
    def img = docker.build("azouiten/chromium-headless:0.1")
    img.inside {
        sh 'chromium --headless --no-sandbox --print-to-pdf=cv_zouiten_en.pdf src/cv_zouiten_en.html'
        sh 'chromium --headless --no-sandbox --print-to-pdf=cv_zouiten_fr.pdf src/cv_zouiten_fr.html'
    }

    withCredentials([usernamePassword(credentialsId: 'cv-upload', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
        sh 'curl --fail-with-body -T cv_zouiten_en.pdf -u "$USERNAME:$PASSWORD" https://cv.zouizoui.ovh/api/cv_zouiten_en.pdf'
        sh 'curl --fail-with-body -T cv_zouiten_fr.pdf -u "$USERNAME:$PASSWORD" https://cv.zouizoui.ovh/api/cv_zouiten_fr.pdf'
    }
}
