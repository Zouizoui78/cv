pipeline {
    agent any

    environment {
        UPLOAD_CREDENTIALS = credentials('cv-upload')
    }

    stages {
        stage('Generate PDFs') {
            steps {
                script {
                    def img = docker.build('azouiten/chromium-headless')
                    img.inside {
                        generatePDFs()
                    }
                }
            }
        }

        stage('Check PDFs size') {
            steps {
                script {
                    def files = ['cv_zouiten_en.pdf', 'cv_zouiten_fr.pdf']
                    def minSize = 50000
                    files.each { file ->
                        def size = sh(script: "stat -c %s ${file}", returnStdout: true).trim().toInteger()
                        if (size < minSize) {
                            error("File ${file} is smaller than ${minSize} bytes (${size} bytes), the generated PDF is probably broken.")
                        }
                    }
                }
            }
        }

        stage('Upload PDFs') {
            steps {
                uploadFiles()
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
    sh("chromium --headless --no-sandbox --print-to-pdf=$output $input")
}

def generatePDFs() {
    generatePDF('src/cv_zouiten_en.html', 'cv_zouiten_en.pdf')
    generatePDF('src/cv_zouiten_fr.html', 'cv_zouiten_fr.pdf')
}

def uploadFile(String file) {
    // If we use groovy string interpolation to pass credentials, they will leak
    // in various place e.g. in process listing.
    // So we escape the '$' so that the credential variables are expanded by the shell
    // using the environment variable.
    sh("curl --fail-with-body -T $file -u \$UPLOAD_CREDENTIALS_USR:\$UPLOAD_CREDENTIALS_PSW https://cv.zouizoui.ovh/api/$file")
}

def uploadFiles() {
    uploadFile('cv_zouiten_en.pdf')
    uploadFile('cv_zouiten_fr.pdf')
}
