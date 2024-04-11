import argparse
from transformers import AutoTokenizer, AutoModelForCausalLM

def generate_text(model_name, prompt, return_tensors, max_length, num_return_sequences, skip_special_tokens):
    tokenizer = AutoTokenizer.from_pretrained(model_name)
    model = AutoModelForCausalLM.from_pretrained(model_name)

    input_ids = tokenizer(prompt, return_tensors=return_tensors).input_ids
    output = model.generate(input_ids, max_length=max_length, num_return_sequences=num_return_sequences)

    generated_texts = [tokenizer.decode(output[i], skip_special_tokens=skip_special_tokens) for i in range(num_return_sequences)]
    return generated_texts

def main(args):
    generated_texts = generate_text(
        model_name=args.model,
        prompt=args.prompt,
        return_tensors=args.return_tensors,
        max_length=args.max_length,
        num_return_sequences=args.num_return_sequences,
        skip_special_tokens=args.skip_special_tokens
    )

    for text in generated_texts:
        print(text)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--model", type=str, default="EleutherAI/pythia-160m")
    parser.add_argument("--prompt", type=str, default="The weather is so nice today,")
    parser.add_argument("--return_tensors", type=str, default="pt")
    parser.add_argument("--max_length", type=int, default=50)
    parser.add_argument("--num_return_sequences", type=int, default=1)
    parser.add_argument("--skip_special_tokens", type=bool, default=True)
    
    args = parser.parse_args()
    main(args)
