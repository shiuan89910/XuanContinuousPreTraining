# Directory Structure

```
ContinuousPreTraining
├── Data
│   ├── LLM
│   ├── NER
│   │   ├── Dict                                     # 人工標註數據 vocab_dict
│   │   ├── Untagged                                 # 未標註領域數據
│   │   ├── Tagged                                   # 弱標註數據
├── Dataset
│   ├── LLM                                          # 大型語言模型連續預訓練數據集
│   ├── NER
│   │   ├── PreTrain                                 # 語言模型連續預訓練數據集
│   │   ├── FineTune                                 # 語言模型微調 NER 數據集
├── Model
│   ├── LLM                                          # 大型語言模型(連續)預訓練模型
│   ├── NER                                          # 語言模型連續預訓練、微調 NER 模型
├── Module
│   ├── Doccano                                      # NER 數據標註工具
│   ├── CrossNER                                     # 語言模型連續預訓練庫
│   ├── DeepKE                                       # 語言模型微調 NER 庫
│   ├── Yarn                                         # 大型語言模型連續預訓練(提升上下文長度)庫
│   ├── LmEvaluationHarness                          # 大型語言模型連續預訓練評估庫
├── Script
│   ├── CrossNER_train.sh                            # 語言模型連續預訓練命令
│   ├── DeepKE_prepare_dict.sh                       # 產生 NER 數據 vocab_dict 命令
│   ├── DeepKE_prepare_data.sh                       # 弱標註 NER 數據命令
│   ├── DeepKE_run_bert.sh                           # 語言模型微調 NER 命令
│   ├── DeepKE_predict.sh                            # 語言模型微調 NER 模型結果預測命令
│   ├── Yarn_tokenization.sh                         # 大型語言模型數據 Tokenized 命令
│   ├── Yarn_truncate.sh                             # 大型語言模型數據 Truncate 命令
│   ├── Yarn_train_64k.sh                            # 大型語言模型連續預訓練(上下文長度64k)命令
│   ├── Yarn_train_128k.sh                           # 大型語言模型連續預訓練(上下文長度128k)命令
│   ├── Yarn_inference.sh                            # 大型語言模型連續預訓練模型推論命令
│   ├── Yarn_eval_128k.sh                            # 大型語言模型連續預訓練模型 perplexity 評估命令
│   ├── Yarn_eval-harness_128k.sh                    # 大型語言模型連續預訓練模型 harness 評估命令
├── requirements.txt                                 # 專案依賴的 Python 套件列表
```

# Windows WSL2 environment config

## Install Nvidia CUDA Driver in Windows
> Select the right Driver (11.8) and Install
> [Link](https://www.nvidia.com/Download/index.aspx?lang=en-us)
> [Link](https://www.nvidia.com.tw/download/driverResults.aspx/193749/tw)

## Install WSL in Windows by Terminal
> [Link](https://learn.microsoft.com/zh-tw/windows/wsl/install)

> ``` CMD
> # Open the Terminal
> wsl --install
> # Create WSL (Ubuntu) User Name and Password
> wsl --list --verbose
> ```

## Install CUDA Toolkit in WSL
> [Link](https://developer.nvidia.com/cuda-11-8-0-download-archive)

> ``` CMD
> wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
> sudo mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600
> wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda-repo-wsl-ubuntu-11-8-local_11.8.0-1_amd64.deb
> sudo dpkg -i cuda-repo-wsl-ubuntu-11-8-local_11.8.0-1_amd64.deb
> sudo cp /var/cuda-repo-wsl-ubuntu-11-8-local/cuda-*-keyring.gpg /usr/share/keyrings/
> sudo apt-get update
> sudo apt-get -y install cuda
> ```

## Follow the Steps below in WSL

> ``` CMD
> cd /usr/local/cuda/bin/
> pwd
> # then Copy the Path 
> cd
> nano .bashrc
> # Add this line at the end of .bashrc
> export PATH=$PATH:(The Copy Path)
> # Ctrl+X => Y => Enter to Exit nano
> sudo reboot
> # Close and new Terminal
> wsl
> # CMD Check
> echo $PATH
> nvidia-smi
> nvcc --version
> ```

## Install Miniconda in WSL
[Link](https://docs.conda.io/projects/miniconda/en/latest/)

> ``` CMD
> # Close and new Terminal
> wsl
> mkdir -p ~/miniconda3
> wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
> bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
> rm -rf ~/miniconda3/miniconda.sh
> ~/miniconda3/bin/conda init bash
> ```

## Follow the Steps below in WSL
> ``` CMD
> sudo apt update && audo apt upgrade
> sudo apt-get install build-essential git g++
> ```

## Install VSCode in Windows and run in WSL
> Install and Open VSCode in Window
> Install WSL in VSCode "Extensions" (In Windows)
> Install Pylance in VSCode "Extensions" (In Windows)
> Install Python in VSCode "Extensions" (In Windows)

> ``` CMD
> # Close and new Terminal
> wsl
> sudo apt update
> sudo reboot
> wsl --shutdown
> wsl
> code .
> ```

> Install Pylance in VSCode "Extensions" (In WSL)
> Install Python in VSCode "Extensions" (In WSL)

# Conda environment
> ``` Conda Prompt
> conda create -n CPT python=3.10.9 -y
> conda init
> conda activate CPT
> conda install -c anaconda git -y
> conda install pytorch==2.0.1 torchvision==0.15.2 torchaudio==2.0.2 pytorch-cuda=11.8 -c pytorch -c nvidia -y
> pip install packaging #==24.0
> pip install -r requirements.txt
> ```

# Doccano

> ``` Shell 1
> doccano init
> doccano createuser --username admin --password pass
> doccano webserver --port 8000
> ```

> ``` Shell 2

> doccano task
> http://127.0.0.1:8000
> ```
