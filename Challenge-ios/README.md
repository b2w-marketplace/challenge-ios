Bibliotecas utilizadas:

>**_Alamofire 4.0_**
/
>**_SwiftyJSON_**

Para utilizar as bibliotecas Alamofire e SwiftyJSON:

Faça o download dos repositórios no Github:<br />
https://github.com/Alamofire/Alamofire<br />
https://github.com/SwiftyJSON/SwiftyJSON

e copie para dentro do seu projeto.

==============================================

ou através do **cocoapods**:

crie um arquivo Podfile contendo:

>_source 'https://github.com/CocoaPods/Specs.git'_<br />
>_platform :ios, '10.0'_<br />
>_use_frameworks!_<br />
>_target '<Your Target Name>' do_<br />
  >_pod 'Alamofire', '~> 4.3'_<br />
  >_pod 'SwiftyJSON'_<br />
>_end_

na pasta do projeto, execute o comando no terminal:

>_pod install_
