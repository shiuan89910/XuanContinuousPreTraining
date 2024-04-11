from deepke.name_entity_re.standard import *
import hydra
from hydra import utils
import pickle
import os
import re
import datasets

def insert_special_tokens(text, tags):
    tag_dict = {word: tag for word, tag in tags}
    words_and_punctuations = re.findall(r'\w+|[^\w\s]', text, re.UNICODE)
    new_text_list = []
    for token in words_and_punctuations:
        if token in tag_dict:
            new_text_list.append(f"<{tag_dict[token]}> {token}")
        else:
            new_text_list.append(token)
    new_text = ''.join([new_text_list[0]] + [f" {t}" if not t.startswith("'") and t not in ',.!?;:"' else t for t in new_text_list[1:]])
    return new_text

@hydra.main(config_path="conf", config_name='config')
def main(cfg):
    if cfg.model_name == 'lstmcrf':
        with open(os.path.join(utils.get_original_cwd(), cfg.data_dir, cfg.model_vocab_path), 'rb') as inp:
            word2id = pickle.load(inp)
            label2id = pickle.load(inp)
            id2label = pickle.load(inp)

        model = InferNer(utils.get_original_cwd() + '/' + "checkpoints/", cfg, len(word2id), len(label2id), word2id, id2label)
    elif cfg.model_name == 'bert':
        model = InferNer(os.path.join(utils.get_original_cwd(), "checkpoints"), cfg)
    else:
        raise NotImplementedError(f"model type {cfg.model_name} not supported")
    text = cfg.text

    print("NER句子:")
    print(text)

    print('NER结果:')
    result = model.predict(text)
    print(result)

    text_with_special_tokens = insert_special_tokens(text, result)
    print('加入特殊標記後的文本:')
    print(text_with_special_tokens)

    dataset = datasets.Dataset.from_dict({'text': [text_with_special_tokens]})
    dataset.save_to_disk(r'C:\Users\godiva\DeepKE\example\ner\standard\Dataset')
 
    
if __name__ == "__main__":
    main()
