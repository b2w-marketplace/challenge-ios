## Installation

Este projeto faz uso do [CocoaPods](https://cocoapods.org). Tudo o que você precisa para configurá-lo corretamente é:

```
pod install
```

## Open Project

Para abrir o projeto use:
```
open desafiob2w.xcworkspace
```

## Projeto

O projeto foi todo desenvolvido em swift 4, para iOS 11.0, propositalmente, pois faz o uso de viewCode, a arquitetura escolhida para solucionar o desafio foi a VIPER, sem utilizar a camada de gerenciamento de fluxo(Router).

Para os serviços de network foi utilizado o framework [Alamofire](https://github.com/Alamofire/Alamofire), e para download de imagens foi utilizado o [Kingfisher](https://github.com/onevcat/Kingfisher).

Na camada de visão foi utilizado o [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD) para apresentação dos feedbacks de loading.

Para especificação das classes de testes foram utilizados o [Quick](https://github.com/Quick/Quick) e o [Nimble](https://github.com/Quick/Nimble) e para criar stubs de chamadas HTTP foi utilizado o [OHHTTPStubs/Swift](https://github.com/AliSoftware/OHHTTPStubs)

Também foi utilizado o [R.swift](https://github.com/mac-cain13/R.swift) para facilitar o uso de alguns componentes  
