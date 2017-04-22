# Hopfield Neural Networks (HNN) for Routing in Communication Networks

This code was developed back in 2010 for my final undergrad project. You can read the whole manuscript [here](https://www.researchgate.net/publication/311885974_Redes_Neurais_de_Hopfield_para_Roteamento_de_Redes_de_Comunicacao_em_FPGA) (as well as [here](https://www.researchgate.net/publication/303773247_Uma_Implementacao_em_FPGA_de_Redes_Neurais_de_Hopfield_para_Roteamento_em_Redes_de_Comunicacao)), but you need to know Portuguese, still here it goes the abstract:

> The routing algorithms influence drastically on the computer networks perfomance. Therefore, good routing algorithm must be created in order to optimize their resources and thus fit to the network needs. Computational Intelligence is a set of techniques with an ability to learn and to deal with new situations. Among these techniques, Neural Networks are inspired by the brain and by the biological neurons. They have the ability of learning and decisionmaking. Hopfield Neural Networks are a kind of Neural Networks with feedback that may be used to route computer networks. Once they are adaptive, they are an interesting option to be used as routing algorithm in order to handle the dynamic behaviour presented in computer networks. However, although they work well to solve the routing problem, they are still slower than the other approaches used nowadays. In the other hand, the neural networks are inherently parallel, once the neurons perform their operations individually. Therefore, they are suited to be implemented on parallel platforms in order to improve their performance. Field Programmable Gate Arrays (FPGA) are programable logic devices organized in a bi-dimensional matrix of logic cells. The architecture presented in the FPGAs turns them inherently parallel, thus they may be used to implement parallel algorithms. Therefore, thanks the parallel behaviour of the neural networks and the parallel architecture of the FPGA, the routing algorithm based on Hopfield Networks running on FPGA may have perfomance similar to the standard algorithms used nowadays. Furthermore, the benefit of the adaptiveness of the neural networks may be used in real computer networks. In this project, it is proposed a Hopfield Neural Networks model for FPGA. It is shown that the model is valid and then it is possible to have the routing algorithm running on FPGAs. Moreover, it is also shown that aproximations of the activation function can be used by the model without lack of perfomance. Furthermore, the proposed model is almost 78 times faster than a sequential version of the Hopfield Neural Networks. Moreover, it has a speed-up of 15 when it is compared with a parallel version of the HNN running on GPUs (Graphic Processing Units). 


If this code helps you, you can cite this work as follows:

* Oliveira Júnior, M. C., & Bastos-Filho, C. J. A. (2016). Uma Implementação em FPGA de Redes Neurais de Hopfield para Roteamento em Redes de Comunicação. In Anais do 10. Congresso Brasileiro de Inteligência Computacional (pp. 1–8). SBIC. https://doi.org/10.21528/CBIC2011-14.3

```tex
@inproceedings{OliveiraJunior2016,
author = {{Oliveira J{\'{u}}nior}, M. C. and Bastos-Filho, C. J. A.},
booktitle = {Anais do 10. Congresso Brasileiro de Intelig{\^{e}}ncia Computacional},
doi = {10.21528/CBIC2011-14.3},
keywords = {fpga,hopfield neural networks,routing algorithms},
mendeley-groups = {my papers},
month = {mar},
pages = {1--8},
publisher = {SBIC},
title = {{Uma Implementa{\c{c}}{\~{a}}o em FPGA de Redes Neurais de Hopfield para Roteamento em Redes de Comunica{\c{c}}{\~{a}}o}},
url = {http://abricom.org.br/eventos/cbic{\_}2011/st{\_}14{\_}3},
year = {2016}
}
```
* Oliveira, MA da C. "Redes Neurais de HOPFIELD para Roteamento de Redes de Comunicação em FPGA." Universidade de Pernambuco, Trabalho de Conclusão de Curso (2011).
```tex
@article{oliveira2011redes,
  title={Redes Neurais de HOPFIELD para Roteamento de Redes de Comunica{\c{c}}{\~a}o em FPGA},
  author={Oliveira, MA da C},
  journal={Universidade de Pernambuco, Trabalho de Conclus{\~a}o de Curso},
  year={2011}
}
```

