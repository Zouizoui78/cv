pipeline {
    agent any

    options {
        // Required to clean workspace before checkout
        skipDefaultCheckout(true)
    }

    environment {
        UPLOAD_CREDENTIALS = credentials('cv-upload')
    }

    stages {
        stage('Checkout sources') {
            steps {
                cleanWs()
                checkout(scm)
            }
        }

        stage('Generate PDFs') {
            steps {
                script {
                    def img = docker.build('azouiten/chromium-headless:0.1')
                    img.inside {
                        generatePDF('src/cv_zouiten_en.html', 'cv_zouiten_en.pdf')
                        generatePDF('src/cv_zouiten_fr.html', 'cv_zouiten_fr.pdf')
                    }
                }
            }
        }

        stage('Upload PDFs') {
            steps {
                uploadFile('cv_zouiten_en.pdf', 'https://cv.zouizoui.ovh/api/cv_zouiten_en.pdf')
                uploadFile('cv_zouiten_fr.pdf', 'https://cv.zouizoui.ovh/api/cv_zouiten_fr.pdf')
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}

def generatePDF(String input, String output) {
    // String interpolation at groovy level requires double quotes
    // "--disable-web-security --virtual-time-budget=10000" is to allow chromium to get external font
    sh("chromium --headless --no-sandbox --disable-web-security --virtual-time-budget=10000 --print-to-pdf=$output $input")
}

def uploadFile(String file, String url) {
    // If we use groovy string interpolation to pass credentials, they will leak
    // in various place e.g. in process listing.
    // So we escape the '$' so that the credential variables are expanded by the shell
    // using the environment variable.
    sh("curl --fail-with-body -T $file -u \$UPLOAD_CREDENTIALS_USR:\$UPLOAD_CREDENTIALS_PSW $url")
}
