import torch
from transformers import BertTokenizer, BertForTokenClassification, BertConfig

loaded_model_path = 'Model/AI_integrated_FT/bert-base-cased'
saved_model_path = 'Model/NER/AI_integrated_FT/bert-base-cased/best_finetune_model.pkl'

tokenizer = BertTokenizer.from_pretrained(loaded_model_path)
config = BertConfig.from_pretrained(loaded_model_path)

model = BertForTokenClassification.from_pretrained(None, config=config, state_dict=torch.load(saved_model_path))
model.eval()

text = "Typical generative model approaches include naive Bayes classifiers, Gaussian mixture models, variational autoencoders and others."
inputs = tokenizer(text, return_tensors="pt", is_split_into_words=False)

with torch.no_grad():
    outputs = model(**inputs)

predictions = outputs.logits.argmax(dim=-1)
for token, prediction in zip(inputs["input_ids"].squeeze().tolist(), predictions.squeeze().tolist()):
    print(f"{tokenizer.decode([token])} - {model.config.id2label[prediction]}")
