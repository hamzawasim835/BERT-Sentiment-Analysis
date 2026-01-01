@echo off
echo --- Creating BERT Environment for RX 7600 ---

:: 1. Create the base environment using your existing YAML logic
:: We exclude torch from the YAML and install it here instead
call conda create -n bert_desktop python=3.10 jupyterlab pandas scikit-learn seaborn matplotlib git -y
call conda activate bert_desktop

:: 2. Install the ROCm-enabled PyTorch for RX 7600 (RDNA 3)
:: We use the specific gfx110X-dgpu index for the RX 7600
pip install --index-url https://d2awnip2yjpvqn.cloudfront.net/v2/gfx110X-dgpu/ torch torchvision torchaudio

:: 3. Install remaining BERT-specific libraries
pip install transformers datasets

echo --- Verification ---
python -c "import torch; print(f'GPU Detected: {torch.cuda.is_available()}'); print(f'Device: {torch.cuda.get_device_name(0)}')"

pause