#import "StoresViewController.h"
#import "Loja.h"
#import "StoreInformationViewController.h"
#import "StoresService.h"

@implementation StoresViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Lojas";
    self.StoreService = [StoresService storesServiceInstance];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.StoreService.stores.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:nil];
        
    Loja *loja = self.StoreService.stores[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat: @"%li - %@", loja.Id, loja.nome];
    

    return cell;
}

- (void) viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Loja *loja = self.StoreService.stores[indexPath.row];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    StoreInformationViewController *storeInformation = [storyboard instantiateViewControllerWithIdentifier:@"StoreInformationViewController"];
    //StoreInformationViewController *storeInformation = [[StoreInformationViewController alloc] initWithNibName: @"StoreInformationViewController" bundle:nil];
    storeInformation.idText = [NSString stringWithFormat:@"%li", loja.Id];
    storeInformation.nameText = loja.nome;
    storeInformation.bairroText = loja.endereco.bairro;
    storeInformation.complementoText = loja.endereco.complemento;
    storeInformation.logradouroText = loja.endereco.logradouro;
    storeInformation.numeroText = loja.endereco.numero;
    storeInformation.cellponeText = loja.telefone;

    self.StoreService.indexSelected = indexPath.row;
    [self.navigationController pushViewController:storeInformation animated:YES];
}


@end
