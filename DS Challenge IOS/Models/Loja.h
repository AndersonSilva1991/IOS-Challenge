#import "Endereco.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Loja : NSObject {
    NSInteger Id;
    Endereco *endereco;
    NSString *nome;
    NSString *telefone;
    UIImage *foto;
}

@property NSInteger Id;
@property Endereco *endereco;
@property NSString *nome, *telefone;
@property UIImage *foto;
@end
