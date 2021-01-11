#import <Foundation/Foundation.h>

@interface Endereco : NSObject {
    NSString *complemento;
    NSString *bairro;
    NSInteger numero;
    NSString *logradouro;
}
@property NSString *complemento, *bairro, *logradouro;
@property NSInteger numero;

@end
