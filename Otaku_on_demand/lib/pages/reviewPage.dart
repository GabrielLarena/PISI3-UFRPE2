import 'package:flutter/material.dart';
import 'package:otaku_on_demand/model/animemodel.dart';
import 'package:provider/provider.dart';
import 'package:otaku_on_demand/pages/AnimePage.dart';
import 'package:otaku_on_demand/pages/listProvider.dart';
import 'package:otaku_on_demand/services/firestore.dart';
import 'package:otaku_on_demand/services/commentProvider.dart';
//import 'package:otaku_on_demand/model/animemodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ListProvider(),
      child: const Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: ReviewPageList(),
        ),
      ),
    );
  }
}

class ReviewPageList extends StatefulWidget {
  const ReviewPageList({super.key});

  @override
  _ReviewPageListState createState() => _ReviewPageListState();
}

class _ReviewPageListState extends State<ReviewPageList> {
  bool isLoading = false;

  late ReviewItem updatedReview;

  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);
    final reviewProvider = Provider.of<ReviewService>(context);

    reviewProvider.fetchReviews();
    firestoreService.fetchData();

    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (int index = 0; index < reviewProvider.reviewList.length; index++)
                _buildReviewContainer(index, firestoreService, reviewProvider),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mostrarPopUpSalvarReview(context);
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(
          Icons.comment_outlined,
          color: Colors.orange,
        ),
      ),
    );
  }

  Widget _buildReviewContainer(int index, FirestoreService firestoreService, ReviewService reviewProvider) {
    final review = reviewProvider.reviewList[index];
    final anime = firestoreService.animeDataList.firstWhere(
          (anime) => anime.animeid == review.animeid,
    );

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimeDetailPage(animeItem: anime),
          ),
        );
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  anime.imageURL,
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.title,
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${anime.name} - Score: ${review.animescore}',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Review: ${review.review}',
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.orange,
                          onPressed: () {
                            editReviewDialog(context, review);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.orange,
                          onPressed: () {
                            _popUpDeletar(context, review.reviewID);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _mostrarPopUpSalvarReview(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {

        final reviewProvider =
        Provider.of<ReviewService>(context, listen: false);

        final firestoreService =
        Provider.of<FirestoreService>(context, listen: false);

        List<String> inputs = [
          "Titulo da review",
          "Escreva a review aqui",
          "Id do anime",
          "Nota do anime",
        ];

        List<TextEditingController> controllers =
        List.generate(4, (index) => TextEditingController());

        return AlertDialog(
          title: const Text('Fazer Review'),
          content: SingleChildScrollView(
            child: Column(
              children: List.generate(
                4,
                    (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(inputs[index]),
                      TextField(
                        controller: controllers[index],
                        decoration: const InputDecoration(
                          hintText: 'Digite aqui',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                List<String> labels =
                controllers.map((controller) => controller.text).toList();

                // Lógica para o botão "Salvar anime"
                if (labels.any((value) => value.isEmpty)) {
                  // Pelo menos um campo está vazio, mostrar mensagem de erro
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Preencha todos os campos'),
                    ),
                  );
                  Navigator.of(context).pop();
                } else if (firestoreService.animeDataList.every((anime) => anime.animeid != labels[2])) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('nenhum anime com esse ID'),
                    ),
                  );
                  Navigator.of(context).pop();
                } else {
                  // Todos os campos estão preenchidos, salvar anime
                  reviewProvider.reviewAdd(
                    labels[0],
                    labels[1],
                    labels[2],
                    labels[3],
                  );
                  Navigator.of(context).pop();
                  // Lógica para salvar as informações do anime
                }
                reviewProvider.fetchReviews();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: const Text('Salvar review'),
            ),
          ],
        );
      },
    );
  }

  void _popUpDeletar(BuildContext context, String reviewid) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Aviso'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Quer mesmo apagar essa review?'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // Lógica para o botão "Sim"
                        final reviewDelete = FirebaseFirestore.instance
                            .collection('animeReview')
                            .doc(reviewid);
                        reviewDelete.delete();
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF0000),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Sim'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Fecha o pop-up
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      child: const Text('Não'),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Future<void> editReviewDialog(BuildContext context, review) async {
    final reviewService =
    Provider.of<ReviewService>(context, listen: false);
    final TextEditingController titleController = TextEditingController();
    final TextEditingController reviewController = TextEditingController();
    final TextEditingController scoreController = TextEditingController();

    // Opções iniciais iguais
    titleController.text = review.title;
    reviewController.text = review.review;
    scoreController.text = review.animescore;

    // ShowDialog
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Review'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField('titulo', titleController),
                _buildTextField('review', reviewController),
                _buildTextField('nota', scoreController),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Update do review com os novos valores
                review = ReviewItem(
                  title: titleController.text,
                  review: reviewController.text,
                  animescore: scoreController.text,
                  // reviewID não muda
                  reviewID: review.reviewID,
                  // animeid não muda
                  animeid: review.animeid, // scoredBy não muda
                );

                //update anime
                reviewService.updateReview(review);

                //update da pagina
                reviewService.fetchReviews();

                Navigator.of(context).pop(); //fecha o dialog// fecha a pagina
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Digite aqui',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}