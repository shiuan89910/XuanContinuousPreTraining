from transformers import GPTNeoXForCausalLM, AutoTokenizer

model_path = r'C:\Users\godiva\DeepKE\example\ner\standard\Model\pythia-160m'

tokenizer = AutoTokenizer.from_pretrained(model_path)
model = GPTNeoXForCausalLM.from_pretrained(model_path)

special_tokens_dict = {
    'domain_special_tokens': 
    [
        '<B-algorithm>', 
        '<I-algorithm>',
        '<B-conference>', 
        '<I-conference>',
        '<B-metrics>', 
        '<I-metrics>',
        '<B-misc>', 
        '<I-misc>',
        '<B-product>', 
        '<I-product>',
        '<B-task>', 
        '<I-task>',
        '<B-field>', 
        '<I-field>',
        '<B-researcher>', 
        '<I-researcher>',
        '<B-organisation>', 
        '<I-organisation>',
        '<B-location>', 
        '<I-location>',
        '<B-country>', 
        '<I-country>',
        '<B-programlang>', 
        '<I-programlang>',
        '<B-person>', 
        '<I-person>',
        '<B-university>', 
        '<I-university>',
        ]
    }

tokenizer.add_special_tokens(special_tokens_dict)
model.resize_token_embeddings(len(tokenizer))

tokenizer.save_pretrained(model_path)
model.save_pretrained(model_path)